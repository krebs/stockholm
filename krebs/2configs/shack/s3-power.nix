{ config, lib, pkgs, ... }:

let
  pkg = pkgs.s3-power;

    home = "/var/lib/s3-power";
    cfg = "${config.krebs.secret.directory}/shack/s3-power.json";
in {
  users.users.s3_power = {
    inherit home;
    createHome = true;
    isSystemUser = true;
    group = "s3_power";
  };
  users.groups.shackDNS = {};
  systemd.services.s3-power = {
    startAt = "daily";
    description = "s3-power";
    environment.CONFIG = "${home}/s3-power.json";
    serviceConfig = {
      Type = "oneshot";
      User = "s3_power";
      ExecStartPre = pkgs.writeDash "s3-power-pre" ''
        install -D -os3_power -m700 ${cfg} ${home}/s3-power.json
      '';
      WorkingDirectory = home;
      PermissionsStartOnly = true;
      ExecStart = "${pkg}/bin/s3-power";
      PrivateTmp = true;
    };
  };
}
