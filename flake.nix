{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-writers.url = "git+https://cgit.krebsco.de/nix-writers";
    nix-writers.inputs.nixpkgs.follows = "nixpkgs";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    buildbot-nix.url = "github:Mic92/buildbot-nix";
    buildbot-nix.inputs.nixpkgs.follows = "nixpkgs";
    kartei.url = "github:krebs/kartei";
    kartei.flake = false;
  };

  description = "stockholm";

  outputs = { self, nixpkgs, nix-writers, buildbot-nix, kartei, ... }: {
    nixosConfigurations = let
      inherit (nixpkgs) lib;
      # Non-default architectures per host. Everything else is x86_64-linux.
      hostSystems = { onebutton = "armv6l-linux"; };
      # Only real, deployable hosts become nixosConfigurations. The test-*
      # directories are CI eval stubs with fake disks and NIX_PATH imports.
      hostNames = lib.filter (n: !lib.hasPrefix "test-" n)
        (lib.attrNames (lib.filterAttrs (_: t: t == "directory")
          (builtins.readDir ./krebs/1systems)));
    in lib.genAttrs hostNames (machineName: nixpkgs.lib.nixosSystem {
      system = hostSystems.${machineName} or "x86_64-linux";
      specialArgs.stockholm = self;
      specialArgs.nix-writers = nix-writers;
      specialArgs.buildbot-nix = buildbot-nix;
      specialArgs.kartei = kartei;
      modules = [
        ./krebs/1systems/${machineName}/config.nix
        {
          krebs.secret.directory = "/var/src/secrets";
        }
      ];
    });

    # Deployment helper: decrypt this host's secrets from pass and rsync them to
    # the target's /var/src/secrets (runtime secret store). Mirrors the krops
    # `pass` source. Usage: nix run .#populate-secrets -- <host> [target]
    apps = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        populate-secrets = pkgs.writeShellApplication {
          name = "populate-secrets";
          runtimeInputs = with pkgs; [ pass gnupg rsync openssh findutils coreutils ];
          text = ''
            host=''${1:?usage: populate-secrets <host> [target]}
            target=''${2:-$host}
            brain=''${PASSWORD_STORE_DIR:-$HOME/brain}
            prefix="krebs-secrets/$host"
            src="$brain/$prefix"
            [ -d "$src" ] || { echo "no secrets for $host at $src" >&2; exit 1; }

            umask 0077
            work=$(mktemp -d)
            trap 'rm -rf "$work"' EXIT
            chmod 700 "$work"

            # Decrypt every secret locally, mirroring the pass tree structure.
            find "$src" -type f -follow ! -name .gpg-id | while read -r gpg_path; do
              rel=''${gpg_path#"$src"}
              rel=''${rel%.gpg}
              out="$work$rel"
              mkdir -p "$(dirname "$out")"
              PASSWORD_STORE_DIR="$brain" pass show "$prefix$rel" > "$out"
            done

            rsync -FrlptD --delete-excluded -e ssh \
              "$work/" "root@$target:/var/src/secrets/"
          '';
        };
      in {
        populate-secrets = {
          type = "app";
          program = "${populate-secrets}/bin/populate-secrets";
        };
      });

    nixosModules =
    let
      inherit (nixpkgs) lib;
    in builtins.listToAttrs
      (map
        (name: {name = lib.removeSuffix ".nix" name; value = import (./krebs/3modules + "/${name}");})
        (lib.filter
          (name: name != "default.nix" && !lib.hasPrefix "." name)
          (lib.attrNames (builtins.readDir ./krebs/3modules))));

    kartei = {
      hosts = self.nixosConfigurations.hotdog.config.krebs.hosts;
      users = self.nixosConfigurations.hotdog.config.krebs.users;
    };
    overlays.default = import ./krebs/5pkgs/default.nix;
    packages = let
      allNames = self.lib.attrNames (self.lib.mapNixDir (x: null) ./krebs/5pkgs/simple);
      appliedOverlay = (system:
        let
          base = self.inputs.nixpkgs.legacyPackages.${system};
          # Apply nix-writers overlay with fixpoint so its functions can find each other
          withWriters = nixpkgs.lib.fix (final: base // nix-writers.overlays.default final base);
        in self.overlays.default {} (withWriters // { lib = self.lib; }));
      # Only include derivations in packages output
      getDerivations = overlay: builtins.listToAttrs (builtins.filter (x: x != null) (map (name:
        let val = overlay.${name} or null;
        in if val != null && (val.type or null) == "derivation"
           then { inherit name; value = val; }
           else null
      ) allNames));
    in nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: getDerivations (appliedOverlay system));
    lib = import (self.outPath + "/lib/pure.nix") { lib = nixpkgs.lib; };
  };
}
