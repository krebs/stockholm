{ r6, w6, ... }:
{
  nets = {
    retiolum = {
      ip4.addr = "10.243.0.1";
      ip6.addr = r6 "ae12";
      aliases = [
        "aergia.r"
      ];
      tinc.pubkey = ''
        -----BEGIN RSA PUBLIC KEY-----
        MIICCgKCAgEAqLtEUExq0qmXbi3aykdoW1WIneePfmm1SnFxCVcEBecJ1z326cNl
        EIhYFSzhctwui0vG1dscmNMXHJ0rRQ0QHks1kp/x2MNMlun3Wl8Md9PQrTRGqZOf
        ltdlNKzn8QbqcQQa9BYMgnFRzhbzzsSO3q5xqncJJ8qSxxWy/boIR9fO+OI/aUfe
        rVLVHj/i5TTAmov5johqQZOyb7ydEbLiTbaaPSo1H/I/as0iv2jaDRdoVBL5/r+q
        JvYFfhcdePjpwjRVNohdRwPquyM2ut91e2UyxD5N5eUoQBn+Xr18f6CQlyfJmMrc
        /oGL+DScrDzFQ/ezCzks3O02dWAmgJsU6odUyNqtdU2x+0lhSqTRH0IXfdkj5n3k
        K5U340/84e8Bn/1BJQoaGpBZJbK8RHdZd/0r+9+aXcI5tm2YAGaPPYzgLUYg06NZ
        fMES28iByiCecIPci4vUZ50oOQFGQYaBNA12JC4TRbL/EfLlaax9bRAaUQr7qIXS
        OBmKrC8eN9QO53T2d2w8Llk5d1rwq0TE3lyJEFLt7sqrHvlBFJ4fpeC+JqZAObqf
        AJlCvFrqDYXBPzuNC2cZQX9QJ4FlGBpOObGg5KtkY0hPUyBO96OMxIDQ2+Jqc7F0
        isAUVvn23h6i3m77jRE1AGFyIC/ReMaCH70/83AJQxRpTkzKcF98xU8CAwEAAQ==
        -----END RSA PUBLIC KEY-----
      '';
      tinc.pubkey_ed25519 = "Jb8RJkm+ufh8o0acM31P2BolEUneYFB4xbtyoLQywLG";
    };
    wiregrill = {
      ip6.addr = w6 "ae12";
      aliases = [
        "aergia.w"
      ];
      wireguard.pubkey = ''
        h2GFkqW1ThHpDiALrLkJEsR5NU1lXHvwk0Kers1vIxg=
      '';
    };
  };
  ssh.pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPAGcqlL5fcxT3iCTlOm5rNPGKZmx1SEDWS71d3Tvbs/";
  syncthing.id = "K5G46ZC-AKEG3WE-MQTG6MB-PC3ZA7O-C2BOKW6-KCXTSEW-RWHKP4B-Q7FCRQ7";
}
