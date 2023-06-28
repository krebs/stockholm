with import ./lib;
{ config, pkgs, ... }: {
  imports = [
    <stockholm/tv>
    <stockholm/tv/2configs/retiolum.nix>
  ];

  krebs.build.host = config.krebs.hosts.querel;
  krebs.build.user = mkForce config.krebs.users.itak;

  boot.initrd.availableKernelModules = [ "ahci" ];
  boot.initrd.luks.devices.querel-luks1 = {
    allowDiscards = true;
    device = "/dev/sda2";
  };
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  environment.systemPackages = [
    pkgs.firefox
    pkgs.gimp
    pkgs.kate
    pkgs.libreoffice
    (pkgs.pidgin.override {
      plugins = [ pkgs.pidgin-otr ];
    })
    pkgs.sxiv
    pkgs.texlive.combined.scheme-full
    pkgs.vim
    pkgs.xsane
    pkgs.zathura
  ];

  fileSystems = {
    "/" = {
      device = "/dev/mapper/querel-root";
      fsType = "ext4";
      options = [ "defaults" "discard" ];
    };
    "/home" = {
      device = "/dev/mapper/querel-home";
      fsType = "ext4";
      options = [ "defaults" "discard" ];
    };
    "/boot" = {
      device = "/dev/sda1";
    };
  };

  hardware.enableRedistributableFirmware = true;
  hardware.pulseaudio.enable = true;

  i18n.defaultLocale = "de_DE.UTF-8";

  networking.networkmanager.enable = true;

  programs.ssh.startAgent = false;

  services.xserver.enable = true;
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.libinput.enable = false;
  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
  };

  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "itak";

  users.users.itak = {
    inherit (config.krebs.users.itak) home uid;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "video"
      "networkmanager"
    ];
  };
}
