{ config, lib, pkgs, ... }:

{
  imports = [
    ../../../krebs
    ../../../krebs/2configs
    ../../../krebs/2configs/nginx.nix
    {
      # Cherry-pick services.nginx.recommendedTlsSettings to fix:
      # nginx: [emerg] "ssl_conf_command" directive is not supported on this platform
      services.nginx.recommendedTlsSettings = lib.mkForce false;
      services.nginx.appendHttpConfig = ''
        ssl_session_timeout 1d;
        ssl_session_cache shared:SSL:10m;
        ssl_session_tickets off;
        ssl_prefer_server_ciphers off;
      '';
    }

    ../../../krebs/2configs/binary-cache/nixos.nix
    ../../../krebs/2configs/ircd.nix
    ../../../krebs/2configs/reaktor2.nix
    ../../../krebs/2configs/wiki.nix
    ../../../krebs/2configs/acme.nix
    ../../../krebs/2configs/mud.nix
    ../../../krebs/2configs/repo-sync.nix

    ../../../krebs/2configs/buildbot-stockholm.nix
    #../../../krebs/2configs/buildbot/master.nix
    #../../../krebs/2configs/buildbot/worker.nix

    ../../../krebs/2configs/cal.nix
    ../../../krebs/2configs/mastodon.nix

    ## (shackie irc bot
    ../../../krebs/2configs/shack/reaktor.nix
  ];

  krebs.build.host = config.krebs.hosts.hotdog;
  krebs.hosts.hotdog.ssh.privkey.path = "${config.krebs.secret.directory}/ssh.id_ed25519";
  krebs.pages.enable = true;

  boot.isContainer = true;
  networking.useDHCP = false;
  krebs.sync-containers3.inContainer = {
    enable = true;
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM20tYHHvwIgrJZzR35ATzH9AlTrM1enNKEQJ7IP6lBh";
  };
}
