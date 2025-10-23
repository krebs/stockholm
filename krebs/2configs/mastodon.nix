{ config, lib, pkgs, ... }:
let
  mastodon-clear-cache = pkgs.writers.writeDashBin "mastodon-clear-cache" ''
    /run/current-system/sw/bin/mastodon-tootctl media remove --prune-profiles --days=14 --concurrency=30
    /run/current-system/sw/bin/mastodon-tootctl media remove-orphans
    /run/current-system/sw/bin/mastodon-tootctl preview_cards remove --days=14
    /run/current-system/sw/bin/mastodon-tootctl accounts prune
    /run/current-system/sw/bin/mastodon-tootctl statuses remove --days 4
    /run/current-system/sw/bin/mastodon-tootctl media remove --days 4
  '';
in
{
  services.postgresql = {
    enable = true;
    dataDir = "/var/state/postgresql/${config.services.postgresql.package.psqlSchema}";
    package = pkgs.postgresql_16;
  };
  systemd.tmpfiles.rules = [
    "d /var/state/postgresql 0700 postgres postgres -"
  ];

  services.mastodon = {
    enable = true;
    localDomain = "social.krebsco.de";
    configureNginx = true;
    streamingProcesses = 3;
    smtp.createLocally = false;
    smtp.fromAddress = "derp";
  };

  security.acme.certs."social.krebsco.de".server = "https://acme-staging-v02.api.letsencrypt.org/directory";

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  systemd.services.mastodon-clear-cache = {
    description = "Mastodon Clear Cache";
    wantedBy = [ "timers.target" ];
    startAt = "daily";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${mastodon-clear-cache}/bin/mastodon-clear-cache";
      User = "mastodon";
      WorkingDirectory = "/var/lib/mastodon";
    };
  };

  environment.systemPackages = [
    mastodon-clear-cache
    (pkgs.writers.writeDashBin "create-mastodon-user" ''
      set -efu
      nick=$1
      /run/current-system/sw/bin/tootctl accounts create "$nick" --email "$nick"@krebsco.de --confirmed
      /run/current-system/sw/bin/tootctl accounts approve "$nick"
    '')
  ];
}
