self: super: let
  stockholm = {
    lib = import ../../lib/pure.nix { lib = super.lib; };
    outPath = toString ../.;
  };
in
with stockholm.lib;

fix (foldl' (flip extends) (self: super) (
  [
    (self: super: { inherit stockholm; })
  ]
  ++
  (map
    (name: import (./. + "/${name}"))
    (filter
      (name: name != "default.nix" && !hasPrefix "." name)
      (attrNames (readDir ./.))))
  ++
  [
    (self: super: {
      brockman = self.haskellPackages.brockman;
      reaktor2 = self.haskellPackages.reaktor2.override {
        blessings =
          self.haskellPackages.callPackage (
            { mkDerivation, base, bytestring, extra, fetchgit, hspec, lib
            , QuickCheck, text, wcwidth
            }:
            mkDerivation {
              pname = "blessings";
              version = "2.5.0";
              src = fetchgit {
                url = "https://cgit.krebsco.de/blessings";
                sha256 = "1spwm4xjz72c76wkkxxxbvxpgkxam344iwq37js5lhfbb2hbjqbx";
                rev = "8f9b20f3aa93f7fbba9d24de7732f4cca0119154";
                fetchSubmodules = true;
              };
              libraryHaskellDepends = [ base bytestring extra text wcwidth ];
              testHaskellDepends = [ base hspec QuickCheck ];
              license = lib.licenses.mit;
            }
          ) {};
      };
    })
  ]
))
