{ config, lib, ... }: let
  slib = lib.slib or (import ../../lib/pure.nix { inherit lib; });

  extend = x: f: {
    lambda = lib.recursiveUpdate x (f x);
    set = lib.recursiveUpdate x f;
  }.${builtins.typeOf f};
in {
  dns.providers = {
    "viljetic.de" = "regfish";
  };
  hosts =
    builtins.mapAttrs
      (hostName: lib.flip (builtins.foldl' extend) [
        {
          name = hostName;
          owner = config.krebs.users.tv;
        }
        (hostConfig: lib.optionalAttrs (lib.hasAttrByPath ["nets" "retiolum"] hostConfig) {
          nets.retiolum = {
            ip6.addr =
              (slib.krebs.genipv6 "retiolum" "tv" { inherit hostName; }).address;
          };
        })
        (let
          pubkey-path = ./wiregrill + "/${hostName}.pub";
        in lib.optionalAttrs (builtins.pathExists pubkey-path) {
          nets.wiregrill = {
            aliases = [
              "${hostName}.w"
            ];
            ip6.addr =
              (slib.krebs.genipv6 "wiregrill" "tv" { inherit hostName; }).address;
            wireguard.pubkey = builtins.readFile pubkey-path;
          };
        })
        (hostConfig: lib.optionalAttrs (hostConfig.ssh.pubkey or null != null) {
          ssh.privkey = builtins.mapAttrs (lib.const lib.mkDefault) rec {
            path = "${config.krebs.secret.directory}/ssh.id_${type}";
            type = builtins.head (lib.toList (builtins.match "ssh-([^ ]+) .*" hostConfig.ssh.pubkey));
          };
        })
      ])
      (lib.mapAttrs'
        (name: type: {
          name = lib.removeSuffix ".nix" name;
          value = lib.toFunction (import (./hosts + "/${name}")) {
            inherit config lib slib;
          };
        })
        (builtins.readDir ./hosts));
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
      pubkey = builtins.readFile (./ssh + "/mv@vod.id_ed25519.pub");
    };
    tv = {
      mail = "tv@nomic.r";
      pgp.pubkeys.default = builtins.readFile ./pgp/CBF89B0B.asc;
      pubkey = builtins.readFile (./ssh + "/tv@wu.id_rsa.pub");
      uid = 1337; # TODO use default and document what has to be done (for vv)
    };
    tv-nomic = {
      inherit (config.krebs.users.tv) mail;
      pubkey = builtins.readFile (./ssh + "/tv@nomic.id_rsa.pub");
    };
    tv-xu = {
      inherit (config.krebs.users.tv) mail;
      pubkey = builtins.readFile (./ssh + "/tv@xu.id_rsa.pub");
    };
    vv = {
      mail = "vv@mu.r";
      uid = 2000; # TODO use default
    };
  };
}
