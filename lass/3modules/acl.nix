{ config, lib, pkgs, ... }: let
  parents = dir:
    if dir == "/" then
      [ dir ]
    else
      [ dir ] ++ parents (builtins.dirOf dir)
    ;
in {
  options.lass.acl = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrsOf (lib.types.submodule ({ config, ... }: {
      options = {
        rule = lib.mkOption {
          type = lib.types.str;
          default = config._module.args.name;
        };
        default = lib.mkOption {
          type = lib.types.bool;
          default = !config.parents;
        };
        recursive = lib.mkOption {
          type = lib.types.bool;
          default = !config.parents;
        };
        parents = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            apply ACL to every parent folder
          '';
        };
      };
    })));
    default = {};
  };
  config = lib.mkIf (config.lass.acl != {}) {
    systemd.services = lib.mapAttrs' (path: rules: lib.nameValuePair "acl-${lib.replaceChars ["/"] ["_"] path}" {
      wantedBy = [ "multi-user.target" ];
      path = [
        pkgs.acl
        pkgs.coreutils
      ];
      serviceConfig = {
        ExecStart = pkgs.writers.writeDash "acl" (lib.concatStrings (
          lib.mapAttrsToList (_: rule: ''
            setfacl -${lib.optionalString rule.recursive "R"}m ${rule.rule} ${path}
            ${lib.optionalString rule.default "setfacl -${lib.optionalString rule.recursive "R"}dm ${rule.rule} ${path}"}
            ${lib.optionalString rule.parents (lib.concatMapStringsSep "\n" (folder: "setfacl -m ${rule.rule} ${folder}") (parents path))}
          '') rules
        ));
        RemainAfterExit = true;
        Type = "simple";
      };
    }) config.lass.acl;
  };
}
