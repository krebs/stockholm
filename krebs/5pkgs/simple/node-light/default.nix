# Upstream ships no package-lock.json, so a generated one is vendored here.
{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage {
  pname = "node-light";
  version = "0-unstable-2018-05-13";

  src = fetchFromGitHub {
    owner = "shackspace";
    repo = "node-light";
    rev = "90a9347b73af3a9960bd992e6293b357226ef6a0";
    sha256 = "1av9w3w8aknlra25jw6gqxzbb01i9kdlfziy29lwz7mnryjayvwk";
  };

  postPatch = ''
    install -m644 ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-cgSg7I/xEBgqeq6x2tB4+2+4jMVUCxXQMa8IU8gtGts=";

  dontNpmBuild = true;

  # data files the service reads at runtime
  postInstall = ''
    install -D -t $out/share storage.json
  '';

  meta = {
    description = "shackspace light control api";
    homepage = "https://github.com/shackspace/node-light";
    mainProgram = "node-light";
  };
}
