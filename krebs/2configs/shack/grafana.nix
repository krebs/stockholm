{ config, ... }: let
  port = 3000;
in {
  networking.firewall.allowedTCPPorts = [ port ]; # legacy
  services.nginx.virtualHosts."grafana.shack" = {
    locations."/" = {
      proxyPass = "http://localhost:${toString port}";
      extraConfig =''
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host             $host;
          proxy_set_header X-Real-IP        $remote_addr;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
      '';

    };
  };
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_port = port;
        http_addr = "0.0.0.0";
      };
      users = {
        allow_sign_up = true;
        allow_org_create = true;
        auto_assign_org = true;
      };
      "auth.anonymous".enabled = true;
      # Runtime secret: grafana's $__file provider reads the admin credentials
      # from the secret store at startup, so nothing is read at eval time.
      security = {
        admin_user = "$__file{${config.krebs.secret.directory}/grafana/admin_user}";
        admin_password = "$__file{${config.krebs.secret.directory}/grafana/admin_password}";
        secret_key = "$__file{${config.krebs.secret.directory}/grafana/secret_key}";
      };
    };
  };
}
