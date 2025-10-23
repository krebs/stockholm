{ mkDerivation, aeson, async, attoparsec, base, blessings
, bytestring, containers, data-default, filepath, hashable, lens
, lens-aeson, lib, network, network-simple, network-simple-tls
, network-uri, pcre-light, process, random, servant-server
, string-conversions, stringsearch, text, time, transformers
, unagi-chan, unix, unordered-containers, vector, wai, warp
, fetchgit
}:
mkDerivation {
  pname = "reaktor2";
  version = "0.4.3";
  src = fetchgit {
    url = "https://cgit.krebsco.de/reaktor2";
    hash = "sha256-gsYMtPaljHBgIVV2+uwyyklOhQjLFdTBVRGG3UVeIVw=";
    rev = "30309581b7ae02b466b466af43009b6b1edb9b39";
    fetchSubmodules = true;
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson async attoparsec base blessings bytestring containers
    data-default filepath hashable lens lens-aeson network
    network-simple network-simple-tls network-uri pcre-light process
    random servant-server string-conversions stringsearch text time
    transformers unagi-chan unix unordered-containers vector wai warp
  ];
  license = lib.licenses.mit;
}
