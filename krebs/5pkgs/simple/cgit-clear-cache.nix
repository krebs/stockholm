{ cache-root ? "/tmp/cgit", findutils, lib, writeDashBin }:

let
  stockholm.lib = import ../../../lib/pure.nix { inherit lib; };
in

writeDashBin "cgit-clear-cache" ''
  set -efu
  ${findutils}/bin/find ${stockholm.lib.shell.escape cache-root} -type f -delete
''
