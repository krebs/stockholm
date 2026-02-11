{ stdenv, fetchurl, python3Packages }:

python3Packages.buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "treq";
  version = "15.1.0";
  pyproject = true;
  build-system = [ python3Packages.setuptools ];
  src = fetchurl {
    url = "mirror://pypi/t/${pname}/${name}.tar.gz";
    sha256= "425a47d5d52a993d51211028fb6ade252e5fbea094e878bb4b644096a7322de8";
  };
  propagatedBuildInputs = with python3Packages; [
    twisted
    pyopenssl
    requests
    service-identity
  ];
}
