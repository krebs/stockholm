{ config, lib, ... }@attrs: let
  inherit (builtins)
    getAttr head mapAttrs match pathExists readDir readFile typeOf;
  inherit (lib)
    const hasAttrByPath mapAttrs' mkDefault mkIf optionalAttrs removeSuffix
    toList;
  slib = import ../../lib/pure.nix { inherit lib; };
in {
  dns.providers = {
    "viljetic.de" = "regfish";
  };
  hosts =
    mapAttrs
      (hostName: hostFile: let
        hostSource = import hostFile;
        hostConfig = getAttr (typeOf hostSource) {
          lambda = hostSource attrs;
          set = hostSource;
        };
      in slib.evalSubmodule slib.types.host [
        hostConfig
        {
          name = hostName;
          owner = config.krebs.users.tv;
        }
        (optionalAttrs (hasAttrByPath ["nets" "retiolum"] hostConfig) {
          nets.retiolum = {
            ip6.addr =
              (slib.krebs.genipv6 "retiolum" "tv" { inherit hostName; }).address;
          };
        })
        (let
          pubkey-path = ./wiregrill + "/${hostName}.pub";
        in optionalAttrs (pathExists pubkey-path) {
          nets.wiregrill = {
            aliases = [
              "${hostName}.w"
            ];
            ip6.addr =
              (slib.krebs.genipv6 "wiregrill" "tv" { inherit hostName; }).address;
            wireguard.pubkey = readFile pubkey-path;
          };
        })
        (host: mkIf (host.config.ssh.pubkey != null) {
          ssh.privkey = mapAttrs (const mkDefault) {
            path = "${config.krebs.secret.directory}/ssh.id_${host.config.ssh.privkey.type}";
            type = head (toList (builtins.match "ssh-([^ ]+) .*" host.config.ssh.pubkey));
          };
        })
      ])
      (mapAttrs'
        (name: type: {
          name = removeSuffix ".nix" name;
          value = ./hosts + "/${name}";
        })
        (readDir ./hosts));
  sitemap = {
    "http://cgit.krebsco.de" = {
      desc = "Git repositories";
    };
    "http://krebs.ni.r" = {
      desc = "krebs-pages mirror";
    };
  };
  users = {
    dv = {
      mail = "dv@alnus.r";
    };
    itak = {
    };
    mv-ni = {
      mail = "mv@ni.r";
      pubkey = readFile (./ssh + "/mv@vod.id_ed25519.pub");
    };
    tv = {
      mail = "tv@nomic.r";
      pgp.pubkeys.default = readFile ./pgp/CBF89B0B.asc;
      pubkey = readFile (./ssh + "/tv@wu.id_rsa.pub");
      uid = 1337; # TODO use default and document what has to be done (for vv)
    };
    tv-nomic = {
      inherit (config.krebs.users.tv) mail;
      pubkey = readFile (./ssh + "/tv@nomic.id_rsa.pub");
    };
    tv-xu = {
      inherit (config.krebs.users.tv) mail;
      pubkey = readFile (./ssh + "/tv@xu.id_rsa.pub");
    };
    vv = {
      mail = "vv@mu.r";
      uid = 2000; # TODO use default
    };
  };
}
