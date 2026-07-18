{ config, ... }:
{
  # Runtime secret: root's password hash is read from the secret store at
  # activation time (systemd), never at eval time. See the host SECRETS.md for
  # the expected file format.
  users.users.root.hashedPasswordFile =
    "${config.krebs.secret.directory}/hashedPassword.root";
}
