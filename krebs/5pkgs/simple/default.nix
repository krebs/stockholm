self: super:

let
  # This callPackage will try to detect obsolete overrides.
  lib = super.stockholm.lib;
  callPackage' = lib.callPackageWith self;
  callPackage = path: args: let
    override = callPackage' path args;
    upstream = lib.optionalAttrs (override ? "name")
      (super.${(lib.parseDrvName override.name).name} or {});
  in if upstream ? "name" &&
        override ? "name" &&
        lib.compareVersions upstream.name override.name != -1
    then lib.trace "Upstream `${upstream.name}' gets overridden by `${override.name}'." override
    else override;

  ## This callPackage will try to detect obsolete overrides.
  #callPackage = path: args: let
  #  pname = (parseDrvName override.name).name;
  #  override = self.callPackage path args;
  #  upstream = super.${pname} or { name = ""; };
  #in
  #  override.overrideAttrs (old: {
  #    name = warnOldVersion upstream.name old.name;
  #  });
in
  lib.mapNixDir (path: callPackage path {}) ./.
