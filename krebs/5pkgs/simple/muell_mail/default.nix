# Repackaged from the removed yarn2nix tooling to the standard buildNpmPackage.
# Upstream ships no package-lock.json, so a generated one is vendored here and
# merged into the source tree before the npm dependency fetch.
{ lib, buildNpmPackage, fetchFromGitHub, runCommand }:
let
  rawSrc = fetchFromGitHub {
    owner = "shackspace";
    repo = "muell_mail";
    rev = "c3e43687879f95e01a82ef176fa15678543b2eb8";
    sha256 = "0hgchwam5ma96s2v6mx2jfkh833psadmisjbm3k3153rlxp46frx";
  };
in
buildNpmPackage {
  pname = "muell_mail";
  version = "0-unstable-2016-09-04";

  src = runCommand "muell_mail-src" { } ''
    cp -r ${rawSrc} $out
    chmod -R +w $out
    cp ${./package-lock.json} $out/package-lock.json
  '';

  npmDepsHash = "sha256-kaoY+NOUe4HJAioKTEop3pOPf37xaZkHMdDDJm2IKQ0=";

  # Pure Node application, nothing to compile.
  dontNpmBuild = true;

  meta = {
    description = "shackspace muell reminder mailer";
    homepage = "https://github.com/shackspace/muell_mail";
    mainProgram = "muell_mail";
  };
}
