# Repackaged from the removed yarn2nix tooling to the standard buildNpmPackage.
# Upstream ships no package-lock.json, so a generated one is vendored here and
# merged into the source tree before the npm dependency fetch.
{ lib, buildNpmPackage, fetchFromGitHub, runCommand }:
let
  rawSrc = fetchFromGitHub {
    owner = "shackspace";
    repo = "muellshack";
    rev = "dc80cf1edaa3d86ec2bebae8596ad1d4c4e3650a";
    sha256 = "1yipr66zhrg5m20pf3rzvgvvl78an6ddkq6zc45rxb2r0i7ipkyh";
  };
in
buildNpmPackage {
  pname = "muellshack";
  version = "0-unstable-2017-02-19";

  src = runCommand "muellshack-src" { } ''
    cp -r ${rawSrc} $out
    chmod -R +w $out
    cp ${./package-lock.json} $out/package-lock.json
  '';

  npmDepsHash = "sha256-BUpne+PFskPgS+58gd4Mf15GwrkQ7u4UpPolk07Kzqs=";

  dontNpmBuild = true;

  # Static data consumed by the service (see 2configs/shack/muellshack.nix).
  postInstall = ''
    install -D -t $out/share $src/static_muelldata.json
    install -D -t $out/share $src/storage.json
  '';

  meta = {
    description = "shackspace muell web api";
    homepage = "https://github.com/shackspace/muellshack";
    mainProgram = "muellshack";
  };
}
