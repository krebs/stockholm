{ config, pkgs, lib, ... }:
with import <stockholm/lib>;
let
  domain = "pad.lassul.us";
in {

  # redirect legacy domain to new one
  services.nginx.virtualHosts."codi.lassul.us" = {
    enableACME = true;
    addSSL = true;
    locations."/".return = "301 https://${domain}\$request_uri";
  };

  services.nginx.virtualHosts.${domain} = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "https://localhost:3091";
      proxyWebsockets = true;
    };
  };

  security.acme.certs.${domain}.group = "hedgecert";
  users.groups.hedgecert.members = [ "codimd" "nginx" ];

  security.dhparams = {
    enable = true;
    params.hedgedoc = {};
  };

  systemd.services.hedgedoc.environment = {
    CMD_COOKIE_POLICY = "none";
    CMD_CSP_ALLOW_FRAMING = "true";
  };
  services.hedgedoc = {
    enable = true;
    configuration.allowOrigin = [ domain ];
    configuration = {
      db = {
        dialect = "sqlite";
        storage = "/var/lib/codimd/db.codimd.sqlite";
      };
      useCDN = false;
      port = 3091;
      domain = domain;
      allowFreeURL = true;

      useSSL = true;
      protocolUseSSL = true;
      sslCAPath = [ "/etc/ssl/certs/ca-certificates.crt" ];
      sslCertPath = "/var/lib/acme/${domain}/cert.pem";
      sslKeyPath = "/var/lib/acme/${domain}/key.pem";
      dhParamPath = config.security.dhparams.params.hedgedoc.path;

    };
  };
}

