# Stockholm-specific types. Registry types (host, net, user, addresses,
# pubkeys, path names, ...) come from kartei's lib/types.nix, which is merged
# into lib.types by lib/pure.nix; this file only adds what stockholm needs on
# top of that.
{ lib, ... }:
let
  inherit (lib)
    all any attrNames concatStringsSep filter flip genid_uint31 hasSuffix head
    importJSON isInt isString length mergeOneOption mkOption mkOptionType
    splitString stringLength test typeOf;
  inherit (lib.types)
    absolute-pathname addCheck either enum host int nullOr path pathname str
    submodule user username;
in

rec {

  boundedInt = min: max: mkOptionType {
    name = "bounded integer";
    check = x: isInt x && min <= x && x <= max;
    merge = mergeOneOption;
  };

  positive = mkOptionType {
    inherit (lib.types.lowerBoundedInt 1) check;
    name = "positive integer";
    merge = mergeOneOption;
  };

  secret-file = submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = pathname;
        default = config._module.args.name;
      };
      path = mkOption {
        type = absolute-pathname;
        default = "/run/keys/${config.name}";
        defaultText = "/run/keys/‹name›";
      };
      mode = mkOption {
        type = file-mode;
        default = "0400";
      };
      owner = mkOption {
        type = user;
      };
      group-name = mkOption {
        type = str;
        default = "root";
      };
      service = mkOption {
        type = systemd.unit-name;
        default = "secret-${lib.systemd.encodeName config.name}.service";
        defaultText = "secret-‹name›.service";
      };
      source-path = mkOption {
        type = str;
        default = config.name;
        defaultText = "‹secrets/‹name››";
      };
    };
  });

  source = submodule ({ config, ... }: {
    options = {
      type = let
        known-types = attrNames source-types;
        type-candidates = filter (k: config.${k} != null) known-types;
      in mkOption {
        default = if length type-candidates == 1
                    then head type-candidates
                    else throw "cannot determine type";
        type = enum known-types;
      };
      file = mkOption {
        apply = x:
          if absolute-pathname.check x
            then { path = x; }
            else x;
        default = null;
        type = nullOr (either absolute-pathname source-types.file);
      };
      git = mkOption {
        default = null;
        type = nullOr source-types.git;
      };
      pass = mkOption {
        default = null;
        type = nullOr source-types.pass;
      };
      pipe = mkOption {
        apply = x:
          if absolute-pathname.check x
            then { command = x; }
            else x;
        default = null;
        type = nullOr (either absolute-pathname source-types.pipe);
      };
      symlink = mkOption {
        type = nullOr (either pathname source-types.symlink);
        default = null;
        apply = x:
          if pathname.check x
            then { target = x; }
            else x;
      };
    };
  });

  source-types = {
    file = submodule {
      options = {
        path = mkOption {
          type = absolute-pathname;
        };
      };
    };
    git = submodule {
      options = {
        ref = mkOption {
          type = str; # TODO types.git.ref
        };
        url = mkOption {
          type = str; # TODO types.git.url
        };
      };
    };
    pass = submodule {
      options = {
        dir = mkOption {
          type = absolute-pathname;
        };
        name = mkOption {
          type = pathname; # TODO relative-pathname
        };
      };
    };
    pipe = submodule {
      options = {
        command = mkOption {
          type = absolute-pathname;
        };
      };
    };
    symlink = submodule {
      options = {
        target = mkOption {
          type = pathname; # TODO relative-pathname
        };
      };
    };

  };

  suffixed-str = suffs:
    mkOptionType {
      name = "string suffixed by ${concatStringsSep ", " suffs}";
      check = x: isString x && any (flip hasSuffix x) suffs;
      merge = mergeOneOption;
    };

  group = submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = username;
        default = config._module.args.name;
        defaultText = "genid_uint31 ‹name›";
      };
      gid = mkOption {
        type = int;
        default = genid_uint31 config.name;
        defaultText = "genid_uint31 ‹name›";
      };
    };
  });

  krebs.file-location = submodule {
    options = {
      # TODO user
      host = mkOption {
        type = host;
      };
      # TODO merge with ssl.privkey.path
      path = mkOption {
        type = either path str;
        apply = x: {
          path = toString x;
          string = x;
        }.${typeOf x};
      };
    };
  };

  flameshot.color =
    either (addCheck str (test "#[0-9A-Fa-f]{6}")) svg.color-keyword;

  file-mode = mkOptionType {
    name = "file mode";
    check = test "[0-7]{4}";
    merge = mergeOneOption;
  };

  haskell.conid = mkOptionType {
    name = "Haskell constructor identifier";
    check = test "[[:upper:]][[:lower:]_[:upper:]0-9']*";
    merge = mergeOneOption;
  };

  haskell.modid = mkOptionType {
    name = "Haskell module identifier";
    check = x: isString x && all haskell.conid.check (splitString "." x);
    merge = mergeOneOption;
  };

  # SVG 1.1, 4.4 Recognized color keyword names
  #
  # svg-colors.json has been generated with:
  #   curl -sS https://www.w3.org/TR/SVG11/types.html#ColorKeywords |
  #   fq -d html '[
  #     grep_by(.["@class"]=="color-keywords") |
  #     grep_by(.["@class"]=="prop-value"and.["#text"]!="").["#text"]
  #   ] | sort'
  #
  svg.color-keyword = enum (importJSON ./svg-colors.json) // {
    name = "SVG 1.1 recognized color keyword";
  };

  # POSIX.1‐2017, 3.190 Group Name
  groupname = mkOptionType {
    name = "POSIX group name";
    check = lib.types.filename.check;
    merge = mergeOneOption;
  };

  systemd.unit-name = mkOptionType {
    name = "systemd unit name";
    check = x:
      test "^[0-9A-Za-z:_.\\-]+@?\\.(service|socket|device|mount|automount|swap|target|path|timer|slice|scope)$" x &&
      stringLength x <= 256;
    merge = mergeOneOption;
  };

}
