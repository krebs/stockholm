{ config, lib, pkgs, ... }:
with import <stockholm/lib>;

{
  imports = [
    <stockholm/lass>
    <stockholm/lass/2configs/retiolum.nix>
    <stockholm/lass/2configs/libvirt.nix>
    <stockholm/lass/2configs/tv.nix>
    <stockholm/lass/2configs/websites/lassulus.nix>
    <stockholm/lass/2configs/telegraf.nix>
    {
      services.nginx.enable = true;
      imports = [
        <stockholm/lass/2configs/websites/domsen.nix>
      ];
      # needed by domsen.nix ^^
      lass.usershadow = {
        enable = true;
      };

      krebs.iptables.tables.filter.INPUT.rules = [
         { predicate = "-p tcp --dport http"; target = "ACCEPT"; }
         { predicate = "-p tcp --dport https"; target = "ACCEPT"; }
      ];
    }
    { # TODO make new hfos.nix out of this vv
      users.users.riot = {
        uid = genid_uint31 "riot";
        isNormalUser = true;
        extraGroups = [ "libvirtd" ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6o6sdTu/CX1LW2Ff5bNDqGEAGwAsjf0iIe5DCdC7YikCct+7x4LTXxY+nDlPMeGcOF88X9/qFwdyh+9E4g0nUAZaeL14Uc14QDqDt/aiKjIXXTepxE/i4JD9YbTqStAnA/HYAExU15yqgUdj2dnHu7OZcGxk0ZR1OY18yclXq7Rq0Fd3pN3lPP1T4QHM9w66r83yJdFV9szvu5ral3/QuxQnCNohTkR6LoJ4Ny2RbMPTRtb+jPbTQYTWUWwV69mB8ot5nRTP4MRM9pu7vnoPF4I2S5DvSnx4C5zdKzsb7zmIvD4AmptZLrXj4UXUf00Xf7Js5W100Ne2yhYyhq+35 riot@lagrange"
        ];
      };
      krebs.iptables.tables.filter.FORWARD.rules = mkBefore [
        { v6 = false; predicate = "--destination 95.216.1.130"; target = "ACCEPT"; }
        { v6 = false; predicate = "--source 95.216.1.130"; target = "ACCEPT"; }
      ];
    }
    {
      users.users.tv = {
        uid = genid_uint31 "tv";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          config.krebs.users.tv.pubkey
        ];
      };
      users.users.makefu = {
        uid = genid_uint31 "makefu";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          config.krebs.users.makefu.pubkey
        ];
      };
      users.extraUsers.dritter = {
        uid = genid_uint31 "dritter";
        isNormalUser = true;
        extraGroups = [
          "download"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnqOWDDk7QkSAvrSLkEoz7dY22+xPyv5JDn2zlfUndfavmTMfZvPx9REMjgULbcCSM4m3Ncf40yUjciDpVleGoEz82+p/ObHAkVWPQyXRS3ZRM2IJJultBHEFc61+61Pi8k3p5pBhPPaig6VncJ4uUuuNqen9jqLesSTVXNtdntU2IvnC8B8k1Kq6fu9q1T2yEOMxkD31D5hVHlqAly0LdRiYvtsRIoCSmRvlpGl70uvPprhQxhtoiEUeDqmIL7BG9x7gU0Swdl7R0/HtFXlFuOwSlNYDmOf/Zrb1jhOpj4AlCliGUkM0iKIJhgH0tnJna6kfkGKHDwuzITGIh6SpZ dritter@Janeway"
        ];
      };
      users.extraUsers.juhulian = {
        uid = 1339;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBQhLGvfv4hyQ/nqJGy1YgHXPSVl6igeWTroJSvAhUFgoh+rG+zvqY0EahKXNb3sq0/OYDCTJVuucc0hgCg7T2KqTqMtTb9EEkRmCFbD7F7DWZojCrh/an6sHneqT5eFvzAPZ8E5hup7oVQnj5P5M3I9keRHBWt1rq6q0IcOEhsFvne4qJc73aLASTJkxzlo5U8ju3JQOl6474ECuSn0lb1fTrQ/SR1NgF7jV11eBldkS8SHEB+2GXjn4Yrn+QUKOnDp+B85vZmVlJSI+7XR1/U/xIbtAjGTEmNwB6cTbBv9NCG9jloDDOZG4ZvzzHYrlBXjaigtQh2/4mrHoKa5eV juhulian@juhulian"
        ];
      };
      users.users.hellrazor = {
        uid = genid_uint31 "hellrazor";
        isNormalUser = true;
        extraGroups = [
          "download"
        ];
        openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQFaYOWRUvHP6I37q9Dd4PJOq8FNQqAeJZ8pLx0G62uC450kbPGcG80rHHvXmk7HqQP6biJmMg48bOsvXAScPot2Qhp1Qc35CuUqVhLiTvUAsi8l/iJjhjZ23yRGDCAmW5+JIOzIvECkcbMnG7YoYAQ9trNGHe9qwGzQGhpt3QVClE23WtE3PVKRLQx1VbiabSnAm6tXVd2zpUoSdpWt8Gpi2taM4XXJ5+l744MNxFHvDapN5xqpYzwrA34Ii13jNLWcGbtgxESpR+VjnamdWByrkBsW4X5/xn2K1I1FrujaM/DBHV1QMaDKst9V8+uL5X7aYNt0OUBu2eyZdg6aujY2BYovB9uRyR1JIuSbA/a54MM96yN9WirMUufJF/YZrV0L631t9EW8ORyWUo1GRzMuBHVHQlfApj7NCU/jEddUuTqKgwyRgTmMFMUI4M0tRULAB/7pBE1Vbcx9tg6RsKIk8VkskfbBJW9Y6Sx6YoFlxPdgMNIrBefqEjIV62piP7YLMlvfIDCJ7TNd9dLN86XGggZ/nD5zt6SL1o61vVnw9If8pHosppxADPJsJvcdN6fOe16/tFAeE0JRo0jTcyFVTBGfhpey+rFfuW8wtUyuO5WPUxkOn7xMHGMWHJAtWX2vwVIDtLxvqn48B4SmEOpPD6ii+vcpwqAex3ycqBUQ==" ];
      };
    }
    {
      #hotdog
      systemd.services."container@hotdog".reloadIfChanged = mkForce false;
      containers.hotdog = {
        config = { ... }: {
          environment.systemPackages = [ pkgs.git ];
          services.openssh.enable = true;
          users.users.root.openssh.authorizedKeys.keys = [
            config.krebs.users.lass.pubkey
          ];
        };
        autoStart = false;
        enableTun = true;
        privateNetwork = true;
        hostAddress = "10.233.2.1";
        localAddress = "10.233.2.2";
      };
    }
    {
      services.nginx.virtualHosts."radio.lassul.us" = {
        enableACME = true;
        addSSL = true;
        locations."/" = {
          # recommendedProxySettings = true;
          proxyWebsockets = true;
          proxyPass = "http://radio.r";
          extraConfig = ''
            proxy_set_header Host radio.r;
            # get source ip for weather reports
            proxy_set_header user-agent "$http_user_agent; client-ip=$remote_addr";
          '';
        };
      };
      krebs.htgen.radio-redirect = {
        port = 8000;
        scriptFile = pkgs.writers.writeDash "redir" ''
          printf 'HTTP/1.1 301 Moved Permanently\r\n'
          printf "Location: http://radio.lassul.us''${Request_URI}\r\n"
          printf '\r\n'
        '';
      };
      krebs.iptables.tables.filter.INPUT.rules = [
        { predicate = "-p tcp --dport 8000"; target = "ACCEPT"; }
      ];
    }
    <stockholm/lass/2configs/exim-smarthost.nix>
    <stockholm/lass/2configs/privoxy-retiolum.nix>
    <stockholm/lass/2configs/binary-cache/server.nix>
    <stockholm/lass/2configs/binary-cache/proxy.nix>
    <stockholm/lass/2configs/iodined.nix>
    <stockholm/lass/2configs/paste.nix>
    <stockholm/lass/2configs/syncthing.nix>
    <stockholm/lass/2configs/green-host.nix>
    <stockholm/lass/2configs/reaktor-coders.nix>
    <stockholm/lass/2configs/ciko.nix>
    <stockholm/lass/2configs/container-networking.nix>
    <stockholm/lass/2configs/services/coms/jitsi.nix>
    <stockholm/lass/2configs/fysiirc.nix>
    <stockholm/lass/2configs/bgt-bot>
    <stockholm/krebs/2configs/mastodon-proxy.nix>
    {
      services.tor = {
        enable = true;
      };
    }
    {
      imports = [
        <stockholm/lass/2configs/realwallpaper.nix>
      ];
      services.nginx.virtualHosts."lassul.us".locations = {
        "= /wallpaper-marker.png".extraConfig = ''
          alias /var/realwallpaper/realwallpaper-marker.png;
        '';
        "= /wallpaper.png".extraConfig = ''
          alias /var/realwallpaper/realwallpaper.png;
        '';
      };
    }
    {
      users.users.jeschli = {
        uid = genid_uint31 "jeschli";
        isNormalUser = true;
        openssh.authorizedKeys.keys = with config.krebs.users; [
          jeschli.pubkey
          jeschli-bln.pubkey
          jeschli-bolide.pubkey
          jeschli-brauerei.pubkey
        ];
      };
      krebs.git.rules = [
        {
          user = with config.krebs.users; [
            jeschli
            jeschli-bln
            jeschli-bolide
            jeschli-brauerei
          ];
          repo = [ config.krebs.git.repos.xmonad-stockholm ];
          perm = with git; push "refs/heads/jeschli*" [ fast-forward non-fast-forward create delete merge ];
        }
        {
          user = with config.krebs.users; [
            jeschli
            jeschli-bln
            jeschli-bolide
            jeschli-brauerei
          ];
          repo = [ config.krebs.git.repos.stockholm ];
          perm = with git; push "refs/heads/staging/jeschli*" [ fast-forward non-fast-forward create delete merge ];
        }
      ];
    }
    {
      krebs.repo-sync.repos.stockholm.timerConfig = {
        OnBootSec = "5min";
        OnUnitInactiveSec = "2min";
        RandomizedDelaySec = "2min";
      };
    }
    <stockholm/lass/2configs/minecraft.nix>
    <stockholm/lass/2configs/codimd.nix>
    <stockholm/lass/2configs/searx.nix>
    {
      services.taskserver = {
        enable = true;
        fqdn = "lassul.us";
        listenHost = "::";
        listenPort = 53589;
        organisations.lass.users = [ "lass" "android" ];
      };
      krebs.iptables.tables.filter.INPUT.rules = [
        { predicate = "-p tcp --dport 53589"; target = "ACCEPT"; }
      ];
    }
    <stockholm/lass/2configs/go.nix>
    {
      environment.systemPackages = [ pkgs.cryptsetup ];
      systemd.services."container@red".reloadIfChanged = mkForce false;
      containers.red = {
        config = { ... }: {
          environment.systemPackages = [ pkgs.git ];
          services.openssh.enable = true;
          users.users.root.openssh.authorizedKeys.keys = [
            config.krebs.users.lass.pubkey
          ];
        };
        autoStart = false;
        enableTun = true;
        privateNetwork = true;
        hostAddress = "10.233.2.3";
        localAddress = "10.233.2.4";
      };
    }
    {
      users.users.download.openssh.authorizedKeys.keys = [
      ];
    }
    {
      lass.nichtparasoup.enable = true;
      services.nginx = {
        enable = true;
        virtualHosts."lol.lassul.us" = {
          forceSSL = true;
          enableACME = true;
          locations."/".extraConfig = ''
            proxy_pass http://localhost:5001;
          '';
        };
      };
    }
    {
      imports = [
        <stockholm/lass/2configs/wiregrill.nix>
      ];
      krebs.iptables.tables.nat.PREROUTING.rules = mkOrder 999 [
        { v6 = false; predicate = "-s 10.244.1.0/24"; target = "ACCEPT"; }
        { v4 = false; predicate = "-s 42:1::/32"; target = "ACCEPT"; }
      ];
      krebs.iptables.tables.filter.FORWARD.rules = mkBefore [
        { predicate = "-i wiregrill -o retiolum"; target = "ACCEPT"; }
        { predicate = "-i retiolum -o wiregrill"; target = "ACCEPT"; }
      ];
      krebs.iptables.tables.nat.POSTROUTING.rules = [
        { v4 = false; predicate = "-s 42:1::/32 ! -d 42:1::/48"; target = "MASQUERADE"; }
        { v6 = false; predicate = "-s 10.244.1.0/24 ! -d 10.244.1.0/24"; target = "MASQUERADE"; }
      ];
      services.dnsmasq = {
        enable = true;
        resolveLocalQueries = false;

        extraConfig= ''
          listen-address=42:1:ce16::1,10.244.1.103
          except-interface=lo
          interface=wiregrill
        '';
      };
    }
    {
      krebs.iptables.tables.filter.INPUT.rules = [
        { predicate = "-p udp --dport 60000:61000"; target = "ACCEPT"; }
      ];
    }
    <stockholm/lass/2configs/services/coms/murmur.nix>
    <stockholm/lass/2configs/docker.nix>
    {
      systemd.services."container@yellow".reloadIfChanged = mkForce false;
      containers.yellow = {
        config = { ... }: {
          environment.systemPackages = [ pkgs.git ];
          services.openssh.enable = true;
          users.users.root.openssh.authorizedKeys.keys = [
            config.krebs.users.lass.pubkey
          ];
        };
        autoStart = false;
        enableTun = true;
        privateNetwork = true;
        hostAddress = "10.233.2.13";
        localAddress = "10.233.2.14";
      };

      services.nginx.virtualHosts."jelly.r" = {
        locations."/".extraConfig = ''
          proxy_pass http://10.233.2.14:8096/;
          proxy_set_header Accept-Encoding "";
        '';
      };
      services.nginx.virtualHosts."flix.r" = {
        locations."/".extraConfig = ''
          proxy_pass http://10.233.2.14:80/;
          proxy_set_header Accept-Encoding "";
        '';
      };
      services.nginx.virtualHosts."lassul.us" = {
        locations."^~ /flix/".extraConfig = ''
          if ($scheme != "https") {
            rewrite ^ https://$host$request_uri permanent;
          }
          auth_basic "Restricted Content";
          auth_basic_user_file ${pkgs.writeText "flix-user-pass" ''
            krebs:$apr1$1Fwt/4T0$YwcUn3OBmtmsGiEPlYWyq0
          ''};
          proxy_pass http://10.233.2.14:80/;
          proxy_set_header Accept-Encoding "";
          sub_filter "https://lassul.us/" "https://lassul.us/flix/";
          sub_filter_once off;
        '';
        locations."^~ /chatty/".extraConfig = ''
          rewrite ^ https://$host/flix/$request_uri permanent;
        '';
        #locations."^~ /transmission".return = "301 https://$host/transmission/web/";
        locations."^~ /transmission/".extraConfig = ''
          if ($scheme != "https") {
            rewrite ^ https://$host$request_uri permanent;
          }
          auth_basic "Restricted Content";
          auth_basic_user_file ${pkgs.writeText "transmission-user-pass" ''
            krebs:$apr1$1Fwt/4T0$YwcUn3OBmtmsGiEPlYWyq0
          ''};
          proxy_pass_header X-Transmission-Session-Id;
          proxy_pass http://10.233.2.14:9091;
        '';
      };

      users.groups.download = {};
      users.users = {
        download = {
          createHome = true;
          group = "download";
          name = "download";
          home = "/var/download";
          useDefaultShell = true;
          uid = genid "download";
          isSystemUser = true;
          openssh.authorizedKeys.keys = with config.krebs.users; [
            lass.pubkey
            lass-android.pubkey
            makefu.pubkey
            palo.pubkey
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDB0d0JA20Vqn7I4lCte6Ne2EOmLZyMJyS9yIKJYXNLjbLwkQ4AYoQKantPBkTxR75M09E7d3j5heuWnCjWH45TrfQfe1EOSSC3ppCI6C6aIVlaNs+KhAYZS0m2Y8WkKn+TT5JLEa8yybYVN/RlZPOilpj/1QgjU6CQK+eJ1k/kK+QFXcwN82GDVh5kbTVcKUNp2tiyxFA+z9LY0xFDg/JHif2ROpjJVLQBJ+YPuOXZN5LDnVcuyLWKThjxy5srQ8iDjoxBg7dwLHjby5Mv41K4W61Gq6xM53gDEgfXk4cQhJnmx7jA/pUnsn2ZQDeww3hcc7vRf8soogXXz2KC9maiq0M/svaATsa9Ul4hrKnqPZP9Q8ScSEAUX+VI+x54iWrnW0p/yqBiRAzwsczdPzaQroUFTBxrq8R/n5TFdSHRMX7fYNOeVMjhfNca/gtfw9dYBVquCvuqUuFiRc0I7yK44rrMjjVQRcAbw6F8O7+04qWCmaJ8MPlmApwu2c05VMv9hiJo5p6PnzterRSLCqF6rIdhSnuOwrUIt1s/V+EEZXHCwSaNLaQJnYL0H9YjaIuGz4c8kVzxw4c0B6nl+hqW5y5/B2cuHiumnlRIDKOIzlv8ufhh21iN7QpIsPizahPezGoT1XqvzeXfH4qryo8O4yTN/PWoA+f7o9POU7L6hQ== lhebendanz@nixos"
            "AAAAB3NzaC1yc2EAAAADAQABAAABgQC4ECL9NSCWqs4KVe+FF+2BPtl5Bv5aQPHqnXllCyiESZykwRKLx6/AbF5SbUAUMVZtp9oDSdp28m3BvVeWJ/q7hAbIxUtfd/jp+JBRZ8Kj6K5GzUO7Bhgl/o0A7xEjAeOKHiYuLjdPMcFUyl6Ah4ey/mcQYf6AdU0+hYUDeUlKe/YxxYD6202W0GJq2xGdIqs/TbopT9iaX+sv0wdXDVfFY72nFqOUwJW3u6O2viKKRugrz/eo50Eo3ts7pYz/FpDXExrUvV9Vu/bQ34pa8nKgF3/AKQHgmzljNQSVZKyAV8OY0UFonjBMXCBg2tXtwfnlzdx2SyuQVv55x+0AuRKsi85G2xLpXu1A3921pseBTW6Q6kbYK9eqxAay2c/kNbwNqFnO+nCvQ6Ier/hvGddOtItMu96IuU2E7mPN6WgvM8/3fjJRFWnZxFxqu/k7iH+yYT8qwRgdiSqZc76qvkYEuabdk2itstTRY0A3SpI3hFMZDw/7bxgMZtqpfyoRk5s= philip@shiki11:15 <Profpatsch> AAAAB3NzaC1yc2EAAAADAQABAAABgQC4ECL9NSCWqs4KVe+FF+2BPtl5Bv5aQPHqnXllCyiESZykwRKLx6/AbF5SbUAUMVZtp9oDSdp28m3BvVeWJ/q7hAbIxUtfd/jp+JBRZ8Kj6K5GzUO7Bhgl/o0A7xEjAeOKHiYuLjdPMcFUyl6Ah4ey/mcQYf6AdU0+hYUDeUlKe/YxxYD6202W0GJq2xGdIqs/TbopT9iaX+sv0wdXDVfFY72nFqOUwJW3u6O2viKKRugrz/eo50Eo3ts7pYz/FpDXExrUvV9Vu/bQ34pa8nKgF3/AKQHgmzljNQSVZKyAV8OY0UFonjBMXCBg2tXtwfnlzdx2SyuQVv55x+0AuRKsi85G2xLpXu1A3921pseBTW6Q6kbYK9eqxAay2c/kNbwNqFnO+nCvQ6Ier/hvGddOtItMu96IuU2E7mPN6WgvM8/3fjJRFWnZxFxqu/k7iH+yYT8qwRgdiSqZc76qvkYEuabdk2itstTRY0A3SpI3hFMZDw/7bxgMZtqpfyoRk5s= philip@shiki"
            mic92.pubkey
            qubasa.pubkey
          ];
        };
      };

      system.activationScripts.downloadFolder = ''
        mkdir -p /var/download
        chmod 775 /var/download
        ln -fnsT /var/lib/containers/yellow/var/download/finished /var/download/finished || :
        chown download: /var/download/finished
      '';

      fileSystems."/export/download" = {
        device = "/var/lib/containers/yellow/var/download/finished";
        options = [ "bind" ];
      };
      services.nfs.server = {
        enable = true;
        exports = ''
          /export 42::/16(insecure,ro,crossmnt)
        '';
        lockdPort = 4001;
        mountdPort = 4002;
        statdPort = 4000;
      };

      services.samba = {
        enable = true;
        enableNmbd = false;
        extraConfig = ''
          workgroup = WORKGROUP
          netbios name = PRISM
          server string = ${config.networking.hostName}
          # only allow retiolum addresses
          hosts allow = 42::/16 10.243.0.0/16

          # Use sendfile() for performance gain
          use sendfile = true

          # No NetBIOS is needed
          disable netbios = true

          # Only mangle non-valid NTFS names, don't care about DOS support
          mangled names = illegal

          # Performance optimizations
          socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=65536 SO_SNDBUF=65536

          # Disable all printing
          load printers = false
          disable spoolss = true
          printcap name = /dev/null

          map to guest = Bad User
          max log size = 50
          dns proxy = no
          security = user

          [global]
          syslog only = yes
        '';
        shares.public = {
          comment = "Warez";
          path = "/export";
          public = "yes";
          "only guest" = "yes";
          "create mask" = "0644";
          "directory mask" = "2777";
          writable = "no";
          printable = "no";
        };
      };

      krebs.iptables.tables.filter.INPUT.rules = [
         # smbd
         { predicate = "-i retiolum -p tcp --dport 445"; target = "ACCEPT"; }

         { predicate = "-i retiolum -p tcp --dport 111"; target = "ACCEPT"; }
         { predicate = "-i retiolum -p udp --dport 111"; target = "ACCEPT"; }
         { predicate = "-i retiolum -p tcp --dport 2049"; target = "ACCEPT"; }
         { predicate = "-i retiolum -p udp --dport 2049"; target = "ACCEPT"; }
         { predicate = "-i retiolum -p tcp --dport 4000:4002"; target = "ACCEPT"; }
         { predicate = "-i retiolum -p udp --dport 4000:4002"; target = "ACCEPT"; }
         { predicate = "-i wiregrill -p tcp --dport 111"; target = "ACCEPT"; }
         { predicate = "-i wiregrill -p udp --dport 111"; target = "ACCEPT"; }
         { predicate = "-i wiregrill -p tcp --dport 2049"; target = "ACCEPT"; }
         { predicate = "-i wiregrill -p udp --dport 2049"; target = "ACCEPT"; }
         { predicate = "-i wiregrill -p tcp --dport 4000:4002"; target = "ACCEPT"; }
         { predicate = "-i wiregrill -p udp --dport 4000:4002"; target = "ACCEPT"; }
      ];
    }
    {
      users.users.shannan = {
        uid = genid_uint31 "shannan";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          config.krebs.users.shannan.pubkey
        ];
      };
    }
    {
      nix.trustedUsers = [ "mic92" ];
      users.users.mic92 = {
        uid = genid_uint31 "mic92";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          config.krebs.users.mic92.pubkey
        ];
      };
    }
  ];

  krebs.build.host = config.krebs.hosts.prism;
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
  };

  # prism rsa hack
  services.openssh.hostKeys = [{
    path = toString <secrets> + "ssh.id_rsa";
    type = "rsa";
  }];
}
