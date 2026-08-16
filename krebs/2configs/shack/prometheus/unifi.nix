{ config, ... }:
{
  # environment file holds UNIFI_PASSWORD=...; read at startup, not at eval time
  services.prometheus.exporters.unifi = {
    enable = true;
    unifiAddress = "https://unifi.shack:8443/";
    unifiInsecure = true;
    unifiUsername = "prometheus"; # needed manual login after setup to confirm the password
    environmentFile = "${config.krebs.secret.directory}/shack/unifi-prometheus-env";
  };
}
