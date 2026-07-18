{config, pkgs, lib, ... }:
## Remote LUKS unlock over a tor onion service, from within the initrd.
##
## --- Scripted stage-1 (CURRENTLY ACTIVE) ---
## Unlock command:
##   (brain hosts/puyak/luks-ssd;echo) \
##     | ssh root@$(brain krebs-secrets/puyak/initrd/hostname) 'cat > /crypt-ramfs/passphrase'
##
## Scripted stage-1 is deprecated in nixpkgs (removal scheduled for 26.11).
## The systemd stage-1 replacement is fully worked out below but is left
## disabled on purpose: puyak is a remote host and a broken initrd means it
## cannot be unlocked or reached remotely. Enable + verify with serial/IPMI
## console access before relying on it, then delete the scripted block.
{
  # This remote-unlock initrd relies on scripted stage-1 (extraUtilsCommands,
  # network.postCommands). Newer nixpkgs defaults to systemd stage-1, so pin it.
  boot.initrd.systemd.enable = lib.mkForce false;

  boot.initrd.network.enable = true;
  boot.initrd.network.ssh = {
    enable = true;
    port = 22;
    authorizedKeys =
      config.krebs.users.lass.pubkeys
      ++ config.krebs.users.makefu.pubkeys
      ++ config.krebs.users.tv.pubkeys;
    hostKeys = [ "${config.krebs.secret.directory}/initrd/openssh_host_ecdsa_key" ];
  };
  boot.initrd.availableKernelModules = [ "e1000e" ];

  boot.initrd.secrets = {
    "/etc/tor/onion/bootup" = "${config.krebs.secret.directory}/initrd";
  };

  boot.initrd.extraUtilsCommands = ''
    copy_bin_and_libs ${pkgs.tor}/bin/tor
  '';

  # start tor during boot process
  boot.initrd.network.postCommands = let
    torRc = (pkgs.writeText "tor.rc" ''
      DataDirectory /etc/tor
      SOCKSPort 127.0.0.1:9050 IsolateDestAddr
      SOCKSPort 127.0.0.1:9063
      HiddenServiceDir /etc/tor/onion/bootup
      HiddenServicePort 22 127.0.0.1:22
    '');
  in ''
    echo "tor: preparing onion folder"
    # have to do this otherwise tor does not want to start
    chmod -R 700 /etc/tor

    echo "make sure localhost is up"
    ip a a 127.0.0.1/8 dev lo
    ip link set lo up

    echo "tor: starting tor"
    tor -f ${torRc} --verify-config
    tor -f ${torRc} &
  '';

  ## --- systemd stage-1 (MODERN REPLACEMENT, currently disabled) ---
  ## To migrate, remove the scripted block above (including the mkForce false
  ## pin, the extraUtilsCommands and the network.postCommands) and uncomment
  ## the block below. The tor daemon then runs as a real initrd systemd unit,
  ## mirroring the upstream boot.initrd.network.openvpn module.
  ##
  ## LUKS is unlocked via systemd-ask-password instead of the /crypt-ramfs
  ## FIFO. The new unlock command becomes (interactive, needs a pty via -t):
  ##   ssh -t root@$(brain krebs-secrets/puyak/initrd/hostname) \
  ##     systemd-tty-ask-password-agent
  ## then paste (brain hosts/puyak/luks-ssd). For a non-interactive pipe,
  ## reply directly to the socket advertised in /run/systemd/ask-password/ask.*.
  #
  # boot.initrd.systemd.enable = true;
  #
  # boot.initrd.network.enable = true;
  # boot.initrd.network.ssh = {
  #   enable = true;
  #   port = 22;
  #   authorizedKeys =
  #     config.krebs.users.lass.pubkeys
  #     ++ config.krebs.users.makefu.pubkeys
  #     ++ config.krebs.users.tv.pubkeys;
  #   hostKeys = [ "${config.krebs.secret.directory}/initrd/openssh_host_ecdsa_key" ];
  # };
  # boot.initrd.availableKernelModules = [ "e1000e" ];
  #
  # boot.initrd.secrets = {
  #   "/etc/tor/onion/bootup" = "${config.krebs.secret.directory}/initrd";
  # };
  #
  # # Pull tor (and its libs, resolved automatically) into the systemd initramfs.
  # boot.initrd.systemd.storePaths = [ "${pkgs.tor}/bin/tor" ];
  #
  # boot.initrd.systemd.services.tor = let
  #   torRc = pkgs.writeText "tor.rc" ''
  #     DataDirectory /etc/tor
  #     SOCKSPort 127.0.0.1:9050 IsolateDestAddr
  #     SOCKSPort 127.0.0.1:9063
  #     HiddenServiceDir /etc/tor/onion/bootup
  #     HiddenServicePort 22 127.0.0.1:22
  #   '';
  # in {
  #   description = "Tor onion service for remote LUKS unlock";
  #   wantedBy = [ "initrd.target" ];
  #   # onion keys are copied in by initrd-nixos-copy-secrets; loopback is up
  #   # once systemd's network target is reached.
  #   after = [ "network.target" "initrd-nixos-copy-secrets.service" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     # tor refuses to start unless the HiddenServiceDir is private.
  #     ExecStartPre = "${pkgs.coreutils}/bin/chmod -R 700 /etc/tor";
  #     ExecStart = "${pkgs.tor}/bin/tor -f ${torRc}";
  #   };
  # };
}
