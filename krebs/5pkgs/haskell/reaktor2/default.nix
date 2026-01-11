{ mkDerivation, aeson, async, attoparsec, base, base64, blessings
, bytestring, containers, data-default, fetchgit, filepath
, hashable, lens, lens-aeson, lib, network, network-simple
, network-simple-tls, network-uri, pcre-light, process, random
, servant-server, string-conversions, stringsearch, text, time
, transformers, unagi-chan, unix, unordered-containers, vector, wai
, warp
}:
mkDerivation {
  pname = "reaktor2";
  version = "0.4.4";
  src = fetchgit {
    url = "https://cgit.krebsco.de/reaktor2";
    sha256 = "1r0dbhniq81z2akb3lxng92y288d7pffj5byyq9mbry241np7631";
    rev = "f50e8b2186042f40392c823845eb3a184d0278de";
    fetchSubmodules = true;
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson async attoparsec base base64 blessings bytestring containers
    data-default filepath hashable lens lens-aeson network
    network-simple network-simple-tls network-uri pcre-light process
    random servant-server string-conversions stringsearch text time
    transformers unagi-chan unix unordered-containers vector wai warp
  ];
  license = lib.licenses.mit;
  mainProgram = "reaktor";
}
