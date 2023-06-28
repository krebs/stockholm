with import ./lib;
{ config, pkgs, ... }: {
  boot.tmpOnTmpfs = true;

  krebs.enable = true;

  krebs.build.user = config.krebs.users.tv;

  networking.hostId = mkDefault (hashToLength 8 config.networking.hostName);
  networking.hostName = config.krebs.build.host.name;

  imports = [
    <secrets>
    ./backup.nix
    ./bash
    ./htop.nix
    ./nets/hkw.nix
    ./networkd.nix
    ./nginx
    ./nix.nix
    ./pki
    ./ssh.nix
    ./sshd.nix
    ./vim.nix
    ./xdg.nix
    {
      users = {
        defaultUserShell = "/run/current-system/sw/bin/bash";
        mutableUsers = false;
        users = {
          tv = {
            inherit (config.krebs.users.tv) home uid;
            isNormalUser = true;
            extraGroups = [ "tv" ];
          };
        };
      };
    }
    {
      i18n.defaultLocale = mkDefault "C.UTF-8";
      security.sudo.extraConfig = ''
        Defaults env_keep+="SSH_CLIENT _CURRENT_DESKTOP_NAME"
        Defaults mailto="${config.krebs.users.tv.mail}"
        Defaults !lecture
      '';
      time.timeZone = "Europe/Berlin";
    }

    {
      nixpkgs.config.allowUnfree = false;
    }
    {
      environment.homeBinInPath = true;

      environment.profileRelativeEnvVars.PATH = mkForce [ "/bin" ];

      environment.systemPackages = with pkgs; [
        rxvt_unicode.terminfo
      ];

      environment.shellAliases = mkForce {
        gp = "${pkgs.pari}/bin/gp -q";
        df = "df -h";
        du = "du -h";

        # TODO alias cannot contain #\'
        # "ps?" = "ps ax | head -n 1;ps ax | fgrep -v ' grep --color=auto ' | grep";

        ls = "ls -h --color=auto --group-directories-first";
        dmesg = "dmesg -L --reltime";
        view = "vim -R";
      };

      environment.variables = {
        NIX_PATH = mkForce (concatStringsSep ":" [
          "secrets=/var/src/stockholm/null"
          "/var/src"
        ]);
      };
    }

    {
      services.cron.enable = false;
      services.ntp.enable = false;
      services.timesyncd.enable = true;
    }

    {
      boot.kernel.sysctl = {
        # Enable IPv6 Privacy Extensions
        #
        # XXX use mkForce here because since NixOS 21.11 there's a collision in
        # net.ipv6.conf.default.use_tempaddr, and boot.kernel.sysctl incapable
        # of merging.
        #
        # XXX net.ipv6.conf.all.use_tempaddr is set because it was mentioned in
        # https://tldp.org/HOWTO/Linux+IPv6-HOWTO/ch06s05.html
        # TODO check if that is really necessary, otherwise we can rely solely
        # on networking.tempAddresses in the future (when nothing is <21.11)
        "net.ipv6.conf.all.use_tempaddr" = mkForce 2;
        "net.ipv6.conf.default.use_tempaddr" = mkForce 2;
      };
    }

    {
      tv.iptables.enable = true;
      tv.iptables.accept-echo-request = "internet";
    }

    {
      services.journald.extraConfig = ''
        SystemMaxUse=1G
        RuntimeMaxUse=128M
      '';
    }

    {
      environment.systemPackages = [
        pkgs.field
        pkgs.get
        pkgs.git
        pkgs.git-crypt
        pkgs.git-preview
        pkgs.hashPassword
        pkgs.htop
        pkgs.kpaste
        pkgs.nix-prefetch-scripts
        pkgs.ovh-zone
        pkgs.push
      ];
    }
  ];

  nixpkgs.overlays =
    mkAfter (optional config.hardware.video.hidpi.enable (self: super: {
      alacritty-tv = super.alacritty-tv.override {
        variant = "hidpi";
      };
    }));
}
