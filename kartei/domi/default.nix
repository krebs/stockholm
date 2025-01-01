{ config, ... }:
{
  domi = {
    nets.wiregrill = {
      ip4.addr = "10.244.10.108";
      aliases = [
        "domi.w"
      ];
      owner = config.krebs.users.domi;
      wireguard.pubkey = "Yy1pvM0lEwaXuOwBoFGNYhHeyYEKuR/rovE0/myWyCI=";
    };
  };
}
