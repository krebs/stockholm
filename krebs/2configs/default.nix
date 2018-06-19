{ config, lib, pkgs, ... }:

with import <stockholm/lib>;
{
  imports = [
    ./backup.nix
    (let ca-bundle = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"; in {
      environment.variables = {
        CURL_CA_BUNDLE = ca-bundle;
        GIT_SSL_CAINFO = ca-bundle;
        SSL_CERT_FILE = ca-bundle;
      };
    })
  ];
  krebs.announce-activation.enable = true;
  krebs.enable = true;
  krebs.tinc.retiolum.enable = true;

  krebs.build.user = mkDefault config.krebs.users.krebs;

  networking.hostName = config.krebs.build.host.name;

  nix.maxJobs = 1;
  nix.trustedBinaryCaches = [
    "https://cache.nixos.org"
    "http://cache.nixos.org"
    "http://hydra.nixos.org"
  ];
  nix.useSandbox = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    rxvt_unicode.terminfo
  ];

  programs.ssh.startAgent = false;

  services.openssh = {
    enable = true;
    hostKeys = [
      { type = "ed25519"; path = "/etc/ssh/ssh_host_ed25519_key"; }
    ];
  };
  services.cron.enable = false;
  services.nscd.enable = false;
  services.ntp.enable = false;

  users.mutableUsers = false;
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    # TODO
    config.krebs.users.lass.pubkey
    config.krebs.users.lass-mors.pubkey
    config.krebs.users.makefu.pubkey
    # TODO HARDER:
    config.krebs.users.makefu-omo.pubkey
    config.krebs.users.tv.pubkey
  ];


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
