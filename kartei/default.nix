{ lib, ... }@arg: let
  removeTemplate =
    # TODO don't remove during CI
    lib.flip builtins.removeAttrs ["template"];
in {
  imports =
      (lib.mapAttrsToList
        (name: _type: let
          path = ./. + "/${name}";
        in {
          _file = toString path;
          krebs = import path arg;
        })
        (removeTemplate
          (lib.filterAttrs
            (_name: type: type == "directory")
            (builtins.readDir ./.))));
}
