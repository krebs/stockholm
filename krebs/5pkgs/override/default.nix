self: super: {

  bitlbee-facebook = super.bitlbee-facebook.overrideAttrs (old: {
    src = self.fetchFromGitHub {
      owner = "bitlbee";
      repo = "bitlbee-facebook";
      rev = "49ea312d98b0578b9b2c1ff759e2cfa820a41f4d";
      sha256 = "0zg1p9pyfsdbfqac2qmyzcr6zjibwdn2907qgc808gljfx8bfnmk";
    };
  });

  flameshot = super.flameshot.overrideAttrs (old: rec {
    name = "flameshot-${version}";
    version = "0.10.2";
    src = self.fetchFromGitHub {
      owner = "flameshot-org";
      repo = "flameshot";
      rev = "v${version}";
      sha256 = "sha256-rZUiaS32C77tFJmEkw/9MGbVTVscb6LOCyWaWO5FyR4=";
    };
    patches = old.patches or [] ++ [
      ./flameshot/flameshot_imgur_0.10.2.patch
    ];
  });

  # https://github.com/proot-me/PRoot/issues/106
  proot = self.writeDashBin "proot" ''
    export PROOT_NO_SECCOMP=1
    exec ${super.proot}/bin/proot "$@"
  '';

}
