# Repackaged from the removed yarn2nix tooling to the standard buildNpmPackage.
# Upstream ships no package-lock.json, so a generated one is vendored here and
# merged into the source tree before the npm dependency fetch.
{ lib, buildNpmPackage, fetchFromGitHub, runCommand }:
let
  rawSrc = fetchFromGitHub {
    owner = "shackspace";
    repo = "s3-power";
    rev = "0687ab64";
    sha256 = "1m8h4bwykv24bbgr5v51mam4wsbp5424xcrawhs4izv563jjf130";
  };
in
buildNpmPackage {
  pname = "s3-power";
  version = "0-unstable-2017-08-24";

  src = runCommand "s3-power-src" { } ''
    cp -r ${rawSrc} $out
    chmod -R +w $out
    cp ${./package-lock.json} $out/package-lock.json
  '';

  npmDepsHash = "sha256-lOmWeol/klwVXEk75tMPaYvNXKx3kukvI2KXzkYpeYg=";

  dontNpmBuild = true;

  meta = {
    description = "shackspace s3 power usage collector";
    homepage = "https://github.com/shackspace/s3-power";
    mainProgram = "s3-power";
  };
}
