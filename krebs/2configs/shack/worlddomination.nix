{ config, lib, pkgs, ... }:

with import ../../../lib/pure.nix { inherit lib; };
let
  pkg = pkgs.stdenv.mkDerivation {
    name = "worlddomination-2020-12-01";
    src = pkgs.fetchFromGitHub {
      owner = "shackspace";
      repo = "worlddomination";
      rev = "934387c3525e819e6b5981c417a7561d70b8b61a";
      sha256 = "sha256-AbRqxxY6hYNg4qkk/akuw4f+wJh4nx1hfEA4Lp5B+1E=";
    };
    buildInputs = [
      (pkgs.python310.withPackages (pythonPackages: with pythonPackages; [
        docopt
        LinkHeader
        aiocoap
        grequests
        paramiko
        python
        setuptools
      ]))
    ];
    installPhase = ''
      install -m755 -D backend/push_led.py  $out/bin/push-led
      install -m755 -D backend/loop_single.py  $out/bin/loop-single
      # copy the provided file to the package
      install -m755 -D backend/wd.lst  $out/${wdpath}
    '';
  };
  pythonPackages = pkgs.python3Packages;
  # https://github.com/chrysn/aiocoap

  LinkHeader = pythonPackages.buildPythonPackage {
    name = "LinkHeader-0.4.3";
    src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/27/d4/eb1da743b2dc825e936ef1d9e04356b5701e3a9ea022c7aaffdf4f6b0594/LinkHeader-0.4.3.tar.gz"; sha256 = "7fbbc35c0ba3fbbc530571db7e1c886e7db3d718b29b345848ac9686f21b50c3"; };
    propagatedBuildInputs = [ ];
    meta = with pkgs.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Parse and format link headers according to RFC 5988 \"Web Linking\"";
    };
  };
  wdpath = "/usr/worlddomination/wd.lst";
  esphost = "10.42.24.7"; # esp8266
  afrihost = "10.42.25.201"; # africa
  timeout = 10; # minutes
in {
  systemd.services.worlddomination = {
    description = "run worlddomination";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "nobody"; # TODO separate user
      ExecStart = "${pkg}/bin/push-led ${esphost} ${pkg}/${wdpath} loop ${toString timeout}";
      Restart = "always";
      PrivateTmp = true;
      PermissionsStartOnly = true;
    };
  };

  systemd.services.worlddomination-africa = {
    description = "run worlddomination africa";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "nobody"; # TODO separate user
      ExecStart = "${pkg}/bin/push-led ${afrihost} ${pkg}/${wdpath} loop ${toString timeout}";
      Restart = "always";
      PrivateTmp = true;
      PermissionsStartOnly = true;
    };
  };
}
