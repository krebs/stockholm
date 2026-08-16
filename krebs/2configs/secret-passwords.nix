{ config, ... }:
{
  # read at activation time, not at eval time; file holds the bare hash
  users.users.root.hashedPasswordFile =
    "${config.krebs.secret.directory}/hashedPassword.root";
}
