{ config, lib, pkgs, ... }:

with builtins;
with lib;
let
  cfg = config.tv.iptables;

  out = {
    options.tv.iptables = api;
    config = mkIf cfg.enable imp;
  };

  api = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    input-internet-accept-new-tcp = mkOption {
      type = with types; listOf str;
      default = [];
    };

    input-retiolum-accept-new-tcp = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  imp = {
    networking.firewall.enable = false;

    systemd.services.tv-iptables = {
      description = "tv-iptables";
      wantedBy = [ "network-pre.target" ];
      before = [ "network-pre.target" ];
      after = [ "systemd-modules-load.service" ];

      path = with pkgs; [
        iptables
      ];
      
      restartIfChanged = true;
      
      serviceConfig = {
        Type = "simple";
        RemainAfterExit = true;
        Restart = "always";
        ExecStart = "@${startScript} tv-iptables_start";
      };
    };
  };


  accept-new-tcp = port:
    "-p tcp -m tcp --dport ${port} -m conntrack --ctstate NEW -j ACCEPT";

  rules = iptables-version:
    pkgs.writeText "tv-iptables-rules${toString iptables-version}" ''
      *nat
      :PREROUTING ACCEPT [0:0]
      :INPUT ACCEPT [0:0]
      :OUTPUT ACCEPT [0:0]
      :POSTROUTING ACCEPT [0:0]
      ${concatMapStringsSep "\n" (rule: "-A PREROUTING ${rule}") ([]
        ++ [
          "! -i retiolum -p tcp -m tcp --dport 22 -j REDIRECT --to-ports 0"
          "-p tcp -m tcp --dport 11423 -j REDIRECT --to-ports 22"
        ]
      )}
      COMMIT
      *filter
      :INPUT DROP [0:0]
      :FORWARD DROP [0:0]
      :OUTPUT ACCEPT [0:0]
      :Retiolum - [0:0]
      ${concatMapStringsSep "\n" (rule: "-A INPUT ${rule}") ([]
        ++ [
          "-m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT"
          "-i lo -j ACCEPT"
        ]
        ++ map accept-new-tcp cfg.input-internet-accept-new-tcp
        ++ ["-i retiolum -j Retiolum"]
      )}
      ${concatMapStringsSep "\n" (rule: "-A Retiolum ${rule}") ([]
        ++ {
          ip4tables = [
            "-p icmp -m icmp --icmp-type echo-request -j ACCEPT"
          ];
          ip6tables = [
            "-p ipv6-icmp -m icmp6 --icmpv6-type echo-request -j ACCEPT"
          ];
        }."ip${toString iptables-version}tables"
        ++ map accept-new-tcp cfg.input-retiolum-accept-new-tcp
        ++ {
          ip4tables = [
            "-p tcp -j REJECT --reject-with tcp-reset"
            "-p udp -j REJECT --reject-with icmp-port-unreachable"
            "-j REJECT --reject-with icmp-proto-unreachable"
          ];
          ip6tables = [
            "-p tcp -j REJECT --reject-with tcp-reset"
            "-p udp -j REJECT --reject-with icmp6-port-unreachable"
            "-j REJECT"
          ];
        }."ip${toString iptables-version}tables"
      )}
      COMMIT
    '';

  startScript = pkgs.writeScript "tv-iptables_start" ''
    #! /bin/sh
    set -euf
    iptables-restore < ${rules 4}
    ip6tables-restore < ${rules 6}
  '';

in
out

#let
#  cfg = config.tv.iptables;
#  arg' = arg // { inherit cfg; };
#in
#
#{
#  options.tv.iptables = import ./options.nix arg';
#  config = lib.mkIf cfg.enable (import ./config.nix arg');
#}
