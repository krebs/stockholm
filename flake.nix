{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-writers = {
      url = "git+https://cgit.krebsco.de/nix-writers";
      flake = false;
    };
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    buildbot-nix.url = "github:Mic92/buildbot-nix";
    buildbot-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  description = "stockholm";

  outputs = { self, nixpkgs, nix-writers, buildbot-nix, ... }: {
    nixosConfigurations = nixpkgs.lib.mapAttrs (machineName: _: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs.stockholm = self;
      specialArgs.nix-writers = nix-writers;
      specialArgs.buildbot-nix = buildbot-nix;
      modules = [
        ./krebs/1systems/${machineName}/config.nix
        {
          krebs.secret.directory = "/var/src/secrets";
        }
      ];
    }) (builtins.readDir ./krebs/1systems);

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
      packageNames = self.lib.attrNames (self.lib.mapNixDir (x: null) ./krebs/5pkgs/simple);
      appliedOverlay = (system: self.overlays.default {} (self.inputs.nixpkgs.legacyPackages.${system} // { lib = self.lib; }));
    in nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system: self.lib.getAttrs packageNames (appliedOverlay system));
    lib = import (self.outPath + "/lib/pure.nix") { lib = nixpkgs.lib; };
  };
}
