# Repackaged from the removed yarn2nix tooling to the standard buildNpmPackage.
# Upstream ships no package-lock.json, so a generated one is vendored here and
# merged into the source tree before the npm dependency fetch.
{ lib, buildNpmPackage, fetchFromGitHub, runCommand }:
let
  rawSrc = fetchFromGitHub {
    owner = "shackspace";
    repo = "node-light";
    rev = "90a9347b73af3a9960bd992e6293b357226ef6a0";
    sha256 = "1av9w3w8aknlra25jw6gqxzbb01i9kdlfziy29lwz7mnryjayvwk";
  };
in
buildNpmPackage {
  pname = "node-light";
  version = "0-unstable-2018-05-13";

  src = runCommand "node-light-src" { } ''
    cp -r ${rawSrc} $out
    chmod -R +w $out
    cp ${./package-lock.json} $out/package-lock.json
  '';

  npmDepsHash = "sha256-cgSg7I/xEBgqeq6x2tB4+2+4jMVUCxXQMa8IU8gtGts=";

  dontNpmBuild = true;

  # Default state file consumed by the service (see 2configs/shack/node-light.nix).
  postInstall = ''
    install -D -t $out/share $src/storage.json
  '';

  meta = {
    description = "shackspace light control api";
    homepage = "https://github.com/shackspace/node-light";
    mainProgram = "node-light";
  };
}
