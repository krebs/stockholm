{ lib, pkgs, python3Packages, fetchFromGitHub, ... }:

with python3Packages; buildPythonPackage rec {
  name = "repo-sync-${version}";
  version = "1.0.0";
  pyproject = true;
  build-system = [ python3Packages.setuptools ];
  propagatedBuildInputs = [
    docopt
    gitpython
    pkgs.git
  ];
  src = fetchFromGitHub {
    owner = "krebs";
    repo = "repo-sync";
    rev = version;
    hash = "sha256-dkhPUaCL+tZn5rF7NN8A6NK/0tz669dLLYRGtRxO+fM=";
  };
  meta = {
    homepage = http://github.com/makefu/repo-sync;
    description = "Sync remotes to other remotes.";
    license = lib.licenses.mit;
  };
}
