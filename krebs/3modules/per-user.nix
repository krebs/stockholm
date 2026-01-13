{ config, pkgs, lib, ... }:
with lib; let
  cfg = config.krebs.per-user;
in {
  options.krebs.per-user = mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        packages = mkOption {
          type = types.listOf types.path;
          default = [];
        };
      };
    });
    default = {};
  };
  config = mkIf (cfg != {}) {
    environment = {
      etc =
        mapAttrs'
          (name: per-user: {
            name = "per-user/${name}";
            value.source = pkgs.buildEnv {
              name = "per-user.${name}";
              paths = per-user.packages;
              pathsToLink = [
                "/bin"
              ];
            };
          })
          (filterAttrs (_: per-user: per-user.packages != []) cfg);

      # XXX this breaks /etc/pam/environment because $LOGNAME doesn't get
      # replaced by @{PAM_USER} the way $USER does.
      # See <nixpkgs/nixos/modules/config/system-environment.nix>
      #profiles = ["/etc/per-user/$LOGNAME"];
      profiles = ["/etc/per-user/$USER"];
    };
  };
}
