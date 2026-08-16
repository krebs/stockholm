{ pkgs, config, ...  }:
let
  tokenPlaceholder = "@TELEGRAM_TOKEN@";
  runtimeConfig = "/run/matterbridge/config.toml";
  # the store-safe template carries a placeholder; the real token is
  # substituted into a runtime-only copy at service start
  configTemplate = (pkgs.formats.toml {}).generate "matterbridge.toml" {
    general = {
      RemoteNickFormat = "[{NICK}] ";
      Charset = "utf-8";
    };
    telegram.krebs.Token = tokenPlaceholder;
    irc.hackint = {
      Server = "irc.hackint.org:6697";
      UseTLS = true;
      Nick = "ponte";
    };
    gateway = [
      {
        name = "krebs-bridge";
        enable = true;
        inout = [
          {
            account = "irc.hackint";
            channel = "#krebs";
          }
          {
            account = "telegram.krebs";
            channel = "-330372458";
          }
        ];
      }
    ];
  };
in {
  services.matterbridge = {
    enable = true;
    configPath = runtimeConfig;
  };

  systemd.services.matterbridge.serviceConfig = {
    RuntimeDirectory = "matterbridge";
    RuntimeDirectoryMode = "0700";
    LoadCredential = "telegram.token:${config.krebs.secret.directory}/telegram.token";
    ExecStartPre = pkgs.writeDash "matterbridge-render-config" ''
      set -efu
      token=$(${pkgs.coreutils}/bin/tr -d '\n' < "$CREDENTIALS_DIRECTORY/telegram.token")
      umask 077
      ${pkgs.gnused}/bin/sed "s|${tokenPlaceholder}|$token|g" \
        ${configTemplate} > ${runtimeConfig}
    '';
  };
}
