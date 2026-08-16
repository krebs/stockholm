# Upstream ships no package-lock.json, so a generated one is vendored here.
{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage {
  pname = "muellshack";
  version = "0-unstable-2017-02-19";

  src = fetchFromGitHub {
    owner = "shackspace";
    repo = "muellshack";
    rev = "dc80cf1edaa3d86ec2bebae8596ad1d4c4e3650a";
    sha256 = "1yipr66zhrg5m20pf3rzvgvvl78an6ddkq6zc45rxb2r0i7ipkyh";
  };

  postPatch = ''
    install -m644 ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-BUpne+PFskPgS+58gd4Mf15GwrkQ7u4UpPolk07Kzqs=";

  dontNpmBuild = true;

  # data files the service reads at runtime
  postInstall = ''
    install -D -t $out/share static_muelldata.json
    install -D -t $out/share storage.json
  '';

  meta = {
    description = "shackspace muell web api";
    homepage = "https://github.com/shackspace/muellshack";
    mainProgram = "muellshack";
  };
}
