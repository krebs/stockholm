{ config, ... }:
{
  # NOTE: currently disabled on all hosts. The unifi exporter password is
  # provided at runtime via an environment file (UNIFI_PASSWORD=...), so no
  # secret is read at eval time. See the host SECRETS.md for the file format.
  services.prometheus.exporters.unifi = {
    enable = true;
    unifiAddress = "https://unifi.shack:8443/";
    unifiInsecure = true;
    unifiUsername = "prometheus"; # needed manual login after setup to confirm the password
    environmentFile = "${config.krebs.secret.directory}/shack/unifi-prometheus-env";
  };
}
