{pkgs, ... }: # hostname: influx.shack
let
  port = 8086;
  collectd-port = 25826;
  db = "collectd_db";
in
{
  networking.firewall.allowedTCPPorts = [ port ]; # for legacy applications
  networking.firewall.allowedUDPPorts = [ collectd-port ];
  services.nginx.virtualHosts."influx.shack" = {
    # Disable constant GET request logging.
    # $loggable map is defined in 1/wolf
    extraConfig = ''
      access_log syslog:server=unix:/dev/log combined if=$loggable;
    '';
    locations."/" = {
      proxyPass = "http://localhost:${toString port}/";
      extraConfig = ''
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host             $host;
          proxy_set_header X-Real-IP        $remote_addr;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";

          proxy_buffering off;
      '';
    };
  };
  nixpkgs.overlays = [ 
    (self: super:
      {
        # Hotfix for https://github.com/NixOS/nixpkgs/issues/157543
        collectd = super.collectd.override { xen = null; };
      }
    )
  ];
  services.influxdb = {
    enable = true;
    extraConfig = {
      http.bind-address = "0.0.0.0:${toString port}";
      http.log-enabled = false;
      http.write-tracing = false;
      http.suppress-write-log = true;
      data.trace-logging-enabled = false;
      data.query-log-enabled = false;
      monitoring.enabled = false;
      collectd = [{
        enabled = true;
        typesdb = "${pkgs.collectd}/share/collectd/types.db";
        database = db;
        bind-address = ":${toString collectd-port}";
      }];
    };
  };
}
