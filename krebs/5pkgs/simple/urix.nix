{ pkgs, lib, writeDash }:

let
  stockholm.lib = import ../../../lib/pure.nix { inherit lib; };
in

# urix - URI eXtractor
# Extract all the URIs from standard input and write them to standard output!
# usage: urix < SOMEFILE

writeDash "urix" ''
  exec ${pkgs.gnugrep}/bin/grep -Eo '\b${stockholm.lib.uri.posix-extended-regex}\b'
''
