# usage: nix-instantiate --eval --json --strict ci.nix | jq .
#
# Emits { <host> = <build-script>; } where each build-script realises that
# host's flake nixosConfiguration toplevel. Consumed by krebs.ci (buildbot) and
# by .gitlab-ci.yml. Only x86_64-linux hosts are built here; other targets
# (e.g. the armv6l onebutton) need emulation and are skipped.
let
  flake = builtins.getFlake (toString ./.);
  lib = flake.inputs.nixpkgs.lib;
  pkgs = flake.inputs.nixpkgs.legacyPackages.x86_64-linux;

  x86Hosts = lib.filterAttrs
    (_: cfg: cfg.pkgs.system == "x86_64-linux")
    flake.nixosConfigurations;

  buildScript = name: _:
    toString (pkgs.writeShellScript "build-${name}" ''
      exec ${pkgs.nix}/bin/nix build --no-link --print-out-paths \
        "${toString ./.}#nixosConfigurations.${name}.config.system.build.toplevel"
    '');
in
  builtins.mapAttrs buildScript x86Hosts
