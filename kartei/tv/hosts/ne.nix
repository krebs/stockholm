{ config, ... }: {
  extraZones = {
    "krebsco.de" = ''
      @ 60 IN MX 5 ne
      @ 60 IN TXT "v=spf1 mx -all"
      ne 60 IN A ${config.krebs.hosts.ne.nets.internet.ip4.addr}
      ne 60 IN AAAA ${config.krebs.hosts.ne.nets.internet.ip6.addr}
      cgit 60 IN A ${config.krebs.hosts.ne.nets.internet.ip4.addr}
      cgit 60 IN AAAA ${config.krebs.hosts.ne.nets.internet.ip6.addr}
      cgit.ne 60 IN A ${config.krebs.hosts.ne.nets.internet.ip4.addr}
      search.ne 60 IN AAAA ${config.krebs.hosts.ne.nets.internet.ip6.addr}
      tv 300 IN NS ne
    '';
  };
  nets = {
    internet = {
      aliases = [
        "ne.i"
        "cgit.ne.i"
      ];
      ip4 = {
        addr = "159.195.31.38";
      };
      ip6 = {
        addr = "2a0a:4cc0:c1:5eb0::1";
        prefixLength = 64;
      };
      ssh.port = 11423;
    };
    mycelium = {
      aliases = [
        "ne.m"
      ];
      ip6.addr = "45f:fa21:4bdd:a758:8091:947d:fe84:fac3";
      via = config.krebs.hosts.ne.nets.internet;
    };
    retiolum = {
      aliases = [
        "ne.r"
        "cgit.ne.r"
        "krebs.ne.r"
        "search.ne.r"
        "p.ne.r"
        "p.tv.r"
      ];
      ip4.addr = "10.243.113.224";
      via = config.krebs.hosts.ne.nets.internet;
    };
    wiregrill = {
      ip4.addr = "10.244.3.2";
      via = config.krebs.hosts.ne.nets.internet;
      wireguard.subnets = [
        (slib.krebs.genipv6 "wiregrill" "tv" 0).subnetCIDR
      ];
    };
  };
}
