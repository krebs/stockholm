# Upstream ships no package-lock.json, so a generated one is vendored here.
{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage {
  pname = "muell_mail";
  version = "0-unstable-2016-09-04";

  src = fetchFromGitHub {
    owner = "shackspace";
    repo = "muell_mail";
    rev = "c3e43687879f95e01a82ef176fa15678543b2eb8";
    sha256 = "0hgchwam5ma96s2v6mx2jfkh833psadmisjbm3k3153rlxp46frx";
  };

  postPatch = ''
    install -m644 ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-kaoY+NOUe4HJAioKTEop3pOPf37xaZkHMdDDJm2IKQ0=";

  dontNpmBuild = true;

  meta = {
    description = "shackspace muell reminder mailer";
    homepage = "https://github.com/shackspace/muell_mail";
    mainProgram = "muell_mail";
  };
}
