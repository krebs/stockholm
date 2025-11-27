{ config, ... }: {
  extraZones = {
    "krebsco.de" = ''
      ne 60 IN A ${config.krebs.hosts.ne.nets.internet.ip4.addr}
      ne 60 IN AAAA ${config.krebs.hosts.ne.nets.internet.ip6.addr}
      tv 300 IN NS ne
    '';
  };
  nets = {
    internet = {
      aliases = [
        "ne.i"
      ];
      ip4 = rec {
        addr = "159.195.31.38";
        prefix = "${addr}/32";
      };
      ip6 = rec {
        addr = "2a0a:4cc0:c1:5eb0::1";
        prefix = "${addr}/64";
        prefixLength = 64;
      };
      ssh.port = 11423;
    };
    mycelium = {
      aliases = [
        "ne.m"
      ];
      ip6.addr = "45f:fa21:4bdd:a758:8091:947d:fe84:fac3";
    };
    retiolum = {
      aliases = [
        "ne.r"
      ];
    };
    wiregrill = {
      ip4.addr = "10.244.3.2";
    };
  };
}
