{ config, lib, pkgs, ... }:

let
  pkg = pkgs.muell_mail;
    home = "/var/lib/muell_mail";
    cfg = "${config.krebs.secret.directory}/shack/muell_mail.js";
in {
  users.users.muell_mail = {
    inherit home;
    isSystemUser = true;
    createHome = true;
    group = "muell_mail";
  };
  users.groups.muell_mail = {};
  systemd.services.muell_mail = {
    description = "muell_mail";
    wantedBy = [ "multi-user.target" ];
    environment.CONFIG = "${home}/muell_mail.js";
    serviceConfig = {
      User = "muell_mail";
      ExecStartPre = pkgs.writeDash "muell_mail-pre" ''
        install -D -omuell_mail -m700 ${cfg} ${home}/muell_mail.js
      '';
      WorkingDirectory = home;
      PermissionsStartOnly = true;
      ExecStart = "${pkg}/bin/muell_mail";
      PrivateTmp = true;
      Restart = "always";
      RestartSec = "15";
    };
  };
}
