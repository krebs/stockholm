{ config, lib, pkgs, ... }:

with config.krebs.lib;

let
  ip = config.krebs.build.host.nets.internet.ip4.addr;

  inherit (import <stockholm/lass/2configs/websites/util.nix> {inherit lib pkgs;})
    manageCerts
  ;

in {
  imports = [
    ../.
    ../2configs/retiolum.nix
    ../2configs/exim-smarthost.nix
    ../2configs/downloading.nix
    ../2configs/ts3.nix
    ../2configs/bitlbee.nix
    ../2configs/weechat.nix
    ../2configs/privoxy-retiolum.nix
    ../2configs/radio.nix
    ../2configs/buildbot-standalone.nix
    ../2configs/repo-sync.nix
    ../2configs/binary-cache/server.nix
    {
      imports = [
        ../2configs/git.nix
      ];
      krebs.nginx.servers.cgit = {
        server-names = [
          "cgit.lassul.us"
        ];
        locations = [
          (nameValuePair "/.well-known/acme-challenge" ''
            root /var/lib/acme/challenges/cgit.lassul.us/;
          '')
        ];
        ssl = {
          enable = true;
          certificate = "/var/lib/acme/cgit.lassul.us/fullchain.pem";
          certificate_key = "/var/lib/acme/cgit.lassul.us/key.pem";
        };
      };
    }
    {
      users.extraGroups = {
        # ● systemd-tmpfiles-setup.service - Create Volatile Files and Directories
        #    Loaded: loaded (/nix/store/2l33gg7nmncqkpysq9f5fxyhlw6ncm2j-systemd-217/example/systemd/system/systemd-tmpfiles-setup.service)
        #    Active: failed (Result: exit-code) since Mon 2015-03-16 10:29:18 UTC; 4s ago
        #      Docs: man:tmpfiles.d(5)
        #            man:systemd-tmpfiles(8)
        #   Process: 19272 ExecStart=/nix/store/2l33gg7nmncqkpysq9f5fxyhlw6ncm2j-systemd-217/bin/systemd-tmpfiles --create --remove --boot --exclude-prefix=/dev (code=exited, status=1/FAILURE)
        #  Main PID: 19272 (code=exited, status=1/FAILURE)
        #
        # Mar 16 10:29:17 cd systemd-tmpfiles[19272]: [/usr/lib/tmpfiles.d/legacy.conf:26] Unknown group 'lock'.
        # Mar 16 10:29:18 cd systemd-tmpfiles[19272]: Two or more conflicting lines for /var/log/journal configured, ignoring.
        # Mar 16 10:29:18 cd systemd-tmpfiles[19272]: Two or more conflicting lines for /var/log/journal/7b35116927d74ea58785e00b47ac0f0d configured, ignoring.
        # Mar 16 10:29:18 cd systemd[1]: systemd-tmpfiles-setup.service: main process exited, code=exited, status=1/FAILURE
        # Mar 16 10:29:18 cd systemd[1]: Failed to start Create Volatile Files and Directories.
        # Mar 16 10:29:18 cd systemd[1]: Unit systemd-tmpfiles-setup.service entered failed state.
        # Mar 16 10:29:18 cd systemd[1]: systemd-tmpfiles-setup.service failed.
        # warning: error(s) occured while switching to the new configuration
        lock.gid = 10001;
      };
    }
    {
      networking.interfaces.et0.ip4 = [
        {
          address = ip;
          prefixLength = 24;
        }
      ];
      networking.defaultGateway = "213.239.205.225";
      networking.nameservers = [
        "8.8.8.8"
      ];
      services.udev.extraRules = ''
        SUBSYSTEM=="net", ATTR{address}=="54:04:a6:7e:f4:06", NAME="et0"
      '';

    }
    {
      boot.loader.grub = {
        devices = [
          "/dev/sda"
          "/dev/sdb"
        ];
        splashImage = null;
      };

      boot.initrd.availableKernelModules = [
        "ata_piix"
        "vmw_pvscsi"
      ];

      fileSystems."/" = {
        device = "/dev/pool/nix";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/7ca12d8c-606d-41ce-b10d-62b654e50e36";
      };

      fileSystems."/var/download" = {
        device = "/dev/pool/download";
      };

      fileSystems."/srv/http" = {
        device = "/dev/pool/http";
      };

      fileSystems."/srv/o.ubikmedia.de-data" = {
        device = "/dev/pool/owncloud-ubik-data";
      };

      fileSystems."/bku" = {
        device = "/dev/pool/bku";
      };

    }
    {
      sound.enable = false;
    }
    {
      nixpkgs.config.allowUnfree = true;
    }
    {
      #stuff for juhulian
      users.extraUsers.juhulian = {
        name = "juhulian";
        uid = 1339;
        home = "/home/juhulian";
        group = "users";
        createHome = true;
        useDefaultShell = true;
        extraGroups = [
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBQhLGvfv4hyQ/nqJGy1YgHXPSVl6igeWTroJSvAhUFgoh+rG+zvqY0EahKXNb3sq0/OYDCTJVuucc0hgCg7T2KqTqMtTb9EEkRmCFbD7F7DWZojCrh/an6sHneqT5eFvzAPZ8E5hup7oVQnj5P5M3I9keRHBWt1rq6q0IcOEhsFvne4qJc73aLASTJkxzlo5U8ju3JQOl6474ECuSn0lb1fTrQ/SR1NgF7jV11eBldkS8SHEB+2GXjn4Yrn+QUKOnDp+B85vZmVlJSI+7XR1/U/xIbtAjGTEmNwB6cTbBv9NCG9jloDDOZG4ZvzzHYrlBXjaigtQh2/4mrHoKa5eV juhulian@juhulian"
        ];
      };
      krebs.iptables.tables.filter.INPUT.rules = [
        { predicate = "-p udp --dport 60000:61000"; target = "ACCEPT";}
      ];
    }
    {
      environment.systemPackages = [
        pkgs.perlPackages.Plack
      ];
      krebs.iptables.tables.filter.INPUT.rules = [
        { predicate = "-p tcp --dport 8080"; target = "ACCEPT";}
      ];
    }
    {
      users.users.chat.openssh.authorizedKeys.keys = [
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHF9tijlMoEevRZCG1AggukxWggfxPHUwg6Ye113ODG6PZ2m98oSmnsjixDy4GfIJjy+8HBbkwS6iH+fsNk86QtAgFNMjBl+9YvEzNRBzcyCqdOkZFvvZvV2oYA7I15il4ln62PDPKjEIS3YPhZPSwc6GhrlsFTnIG56NF/93IhF7R/FA== JuiceSSH"
        config.krebs.users.lass-uriel.pubkey
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQ8DJhHAqmdrB2+qkV/OuKjR4QDXUww2TWItyDrs+/6F58WacMozgaZr2goA5JQJ5d19nC3LzYb4yLGguADsp987I6cAu5iXPT5PHKc0eRWDN+AGlpTgUtN1BvVrnJZaUJrR9WlHhFYlkOkzAsB15fKYciVWsyxBCVZ+3oiTEjs2L/sfbrgailWqHIUWDftUnJx8EFmSUVZ2GZWklMcgBo0FJD1i0x5u2dQGguNY+28DzQmKgUMS+xD/uUZvrFIWr9I6CBqhsuHJo8n85BT3B3QdG8ARLt5FKPr5L3My6UjlxOkKrDNLjJFjERFCsuIxnrO3tQhvKXQYlOyskHokocYSdcIq8svghJLA3kmRYIjHjZ4y1BNENsk79WyYNMAi5y+A0Evmu+g3ks/DiW3vI/Sw/D3Uc7ilbImpaoL5qUC4+WZM3J2b3Z1AU5D1QiojpKkB9Qt1bokCm8hrRCG9ZDKqAD6IqmI1ARRjfgA4zKwKUhmMqG4p55YGGVf9OeK0rXgX0Z2InyFXeBaU2aBcDfdKD/65w5MnC9CsJnjELdd4r9u2ugTPExzOo3WUlNuOTB1WoZ8CiY2OVGle/E/MzKUDfGuIFhUsFeX0YcLHPbo+mesISNUPaeadSuMuHE8W4FOeEq51toBo/gkxgjtqqWMOd9SxnDQTMBKq3L/w7nEQ== lass@mors"
      ];
    }
    {
      time.timeZone = "Europe/Berlin";
    }
    {
      imports = [
        ../2configs/websites/wohnprojekt-rhh.de.nix
        ../2configs/websites/domsen.nix
      ];
      krebs.iptables.tables.filter.INPUT.rules = [
         { predicate = "-p tcp --dport http"; target = "ACCEPT"; }
         { predicate = "-p tcp --dport https"; target = "ACCEPT"; }
      ];
    }
    {
      services.tor = {
        enable = true;
      };
    }
    {
      security.acme = {
        certs."lassul.us" = {
          email = "lass@lassul.us";
          webroot = "/var/lib/acme/challenges/lassul.us";
          plugins = [
            "account_key.json"
            "key.pem"
            "fullchain.pem"
            "full.pem"
          ];
          allowKeysForGroup = true;
          group = "lasscert";
        };
      };
      users.groups.lasscert.members = [
        "dovecot2"
        "ejabberd"
        "exim"
        "nginx"
      ];
      krebs.nginx.servers."lassul.us" = {
        server-names = [ "lassul.us" ];
        locations = [
          (lib.nameValuePair "/.well-known/acme-challenge" ''
            root /var/lib/acme/challenges/lassul.us/;
          '')
        ];
      };
      lass.ejabberd = {
        enable = true;
        hosts = [ "lassul.us" ];
      };
      krebs.iptables.tables.filter.INPUT.rules = [
        { predicate = "-p tcp --dport xmpp-client"; target = "ACCEPT"; }
        { predicate = "-p tcp --dport xmpp-server"; target = "ACCEPT"; }
      ];
    }
    {
      imports = [
        ../2configs/realwallpaper.nix
      ];
      krebs.nginx.servers."lassul.us".locations = [
        (lib.nameValuePair "/wallpaper.png" ''
          alias /tmp/wallpaper.png;
        '')
      ];
    }
    {
      environment.systemPackages = with pkgs; [
        mk_sql_pair
      ];
    }
    {
      users.users.tv = {
        uid = genid "tv";
        inherit (config.krebs.users.tv) home;
        group = "users";
        createHome = true;
        useDefaultShell = true;
        openssh.authorizedKeys.keys = [
          config.krebs.users.tv.pubkey
        ];
      };
    }
    {
      krebs.nginx = {
        enable = true;
        servers.public = {
          listen = [ "8088" ];
          server-names = [ "default" ];
          locations = [
            (nameValuePair "~ ^/~(.+?)(/.*)?\$" ''
              alias /home/$1/public_html$2;
            '')
          ];
        };
      };
      krebs.iptables.tables.filter.INPUT.rules = [
       { predicate = "-p tcp --dport 8088"; target = "ACCEPT"; }
      ];
    }
  ];

  krebs.build.host = config.krebs.hosts.prism;
}
