{ pkgs, lib, ...  }: {
  services.matterbridge = {
    enable = true;
    configPath = let
      bridgeBotToken = lib.strings.fileContents <secrets/telegram.token>;
    in
      toString ((pkgs.formats.toml {}).generate "config.toml" {
        general = {
          RemoteNickFormat = "[{NICK}] ";
          Charset = "utf-8";
        };
        telegram.krebs.Token = bridgeBotToken;
        irc = let
          Nick = "ponte";
        in {
          hackint = {
            Server = "irc.hackint.org:6697";
            UseTLS = true;
            inherit Nick;
          };
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
      });
  };
}
