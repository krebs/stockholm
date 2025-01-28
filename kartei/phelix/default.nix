{ config, lib, ... }: let
  slib = import ../../lib/pure.nix { inherit lib; };
in {
  users.phelix = {
    mail = "phelix-r@unavailable.network";
  };
  hosts.glanix9001 = {
    owner = config.krebs.users.phelix;
    nets.retiolum = {
      aliases = [ "glanix9001.phelix.r" ];
      ip6.addr = (slib.krebs.genipv6 "retiolum" "phelix" { hostName = "glanix9001"; }).address;
      tinc.pubkey = ''
        -----BEGIN RSA PUBLIC KEY-----
        MIICCgKCAgEAsi4yWZ2ZYHVFpJcy440FO25q443dAWy+nf2kIMA6wcl/oGvPxCRD
        xw4vWKkPqU/OlSjrQrW0EHsQ9FXS9ClzVmqu5Ky6rJeKhik08E4JB15fgWkdIkBL
        /kdqczzKrW4XiW8vv7PGt5NsgOLIcKJHCHrqnkfeUl0CdVw/halVF8FvAyxrW22s
        cZl4r3Ul6AMIUogoH7f8rsLi07HOcFOQSFycquO2YkNineEDaw9GVnNOn4A9sisg
        xyUorrUFNeU7PPlKOk+DHyMSBsjfykkF9blZtZUoMsByMbsNIgLGiz+u429DqrCb
        MOg3YvwijQdrcfcyyNRJxkjaED073SGFjGww/X0rXeesFgRRIMIfnalhkOdUJBuy
        ZLkWA2uUzO2KPiUNXhj5DeE1rkcRFjen871oeWdrx2sYubwNzSeulQ6iEl4iPtgP
        oGPtb3c13WAekQXEPoRqPxWs1jS6U3ljZqbJioA1vxqvvAIco4PAsciSpcJ0jdUU
        GVqkRklNli5lyRKCx4NDYTrEMdjhOXK3HTdpiSD/hcEWTUSK9mic/5uBA0ZfpS3y
        NNvWz7srm1Bo6uzMiHyns/j5SDJkfVaFrn2LdQuFp+2hHEh0orOcn4RJB+k7q0yj
        Y0voh0Hf/cYVLjadAIk6KEhmYBtC+7jRv+TAuCYcsIQySXu0lLs6vrMCAwEAAQ==
        -----END RSA PUBLIC KEY-----
      '';
      tinc.pubkey_ed25519 = "Ed25519PublicKey = de2DF3m7byAhPEcQmfBdcTnBQLx+Nsb8wI7mFJbZQJD";
    };
  };
}
