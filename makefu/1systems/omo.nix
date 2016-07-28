# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  toMapper = id: "/media/crypt${builtins.toString id}";
  byid = dev: "/dev/disk/by-id/" + dev;
  keyFile = byid "usb-Verbatim_STORE_N_GO_070B3CEE0B223954-0:0";
  rootDisk = byid "ata-SanDisk_SD8SNAT128G1122_162099420904";
  rootPartition = byid "ata-SanDisk_SD8SNAT128G1122_162099420904-part2";
  primaryInterface = "enp1s0";
  # cryptsetup luksFormat $dev --cipher aes-xts-plain64 -s 512 -h sha512
  # cryptsetup luksAddKey $dev tmpkey
  # cryptsetup luksOpen $dev crypt0 --key-file tmpkey --keyfile-size=4096
  # mkfs.xfs /dev/mapper/crypt0 -L crypt0

  # omo Chassis:
  # __FRONT_
  # |* d0   |
  # |       |
  # |* d3   |
  # |       |
  # |* d3   |
  # |       |
  # |*      |
  # |* d2   |
  # |  * r0 |
  # |_______|
  cryptDisk0 = byid "ata-ST2000DM001-1CH164_Z240XTT6";
  cryptDisk1 = byid "ata-TP02000GB_TPW151006050068";
  cryptDisk2 = byid "ata-ST4000DM000-1F2168_Z303HVSG";
  # cryptDisk3 = byid "ata-WDC_WD20EARS-00MVWB0_WD-WMAZA1786907";
  # all physical disks

  # TODO callPackage ../3modules/MonitorDisks { disks = allDisks }
  dataDisks = [ cryptDisk0 cryptDisk1 cryptDisk2 ];
  allDisks = [ rootDisk ] ++ dataDisks;
in {
  imports =
    [
      ../.
      # TODO: unlock home partition via ssh
      ../2configs/fs/sda-crypto-root.nix
      ../2configs/zsh-user.nix
      ../2configs/exim-retiolum.nix
      ../2configs/smart-monitor.nix
      ../2configs/mail-client.nix
      #../2configs/graphite-standalone.nix
      #../2configs/share-user-sftp.nix
      ../2configs/omo-share.nix
      ../2configs/tinc/retiolum.nix

      ## as long as pyload is not in nixpkgs:
      # docker run -d -v /var/lib/pyload:/opt/pyload/pyload-config -v /media/crypt0/pyload:/opt/pyload/Downloads --name pyload --restart=always -p 8112:8000 -P writl/pyload
    ];

  networking.firewall.trustedInterfaces = [ primaryInterface ];
  # udp:137 udp:138 tcp:445 tcp:139 - samba, allowed in local net
  # tcp:80          - nginx for sharing files
  # tcp:655 udp:655 - tinc
  # tcp:8111        - graphite
  # tcp:8112        - pyload
  # tcp:9090        - sabnzbd
  # tcp:9200        - elasticsearch
  # tcp:5601        - kibana
  networking.firewall.allowedUDPPorts = [ 655 ];
  networking.firewall.allowedTCPPorts = [ 80 655 5601 8111 8112 9200 9090 ];

  # services.openssh.allowSFTP = false;

  # copy config from <secrets/sabnzbd.ini> to /var/lib/sabnzbd/
  services.sabnzbd.enable = true;
  systemd.services.sabnzbd.environment.SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

  virtualisation.docker.enable = true;
  makefu.ps3netsrv = {
    enable = true;
    servedir = "/media/cryptX/emu/ps3";
  };
  # HDD Array stuff
  services.smartd.devices = builtins.map (x: { device = x; }) allDisks;

  makefu.snapraid = {
    enable = true;
    disks = map toMapper [ 0 1 ];
    parity = toMapper 2;
  };

  # TODO create folders in /media
  system.activationScripts.createCryptFolders = ''
    ${lib.concatMapStringsSep "\n"
      (d: "install -m 755 -d " + (toMapper d) )
      [ 0 1 2 "X" ]}
  '';
  environment.systemPackages = [ pkgs.mergerfs ];
  fileSystems = let
    cryptMount = name:
      { "/media/${name}" = { device = "/dev/mapper/${name}"; fsType = "xfs"; };};
  in   cryptMount "crypt0"
    // cryptMount "crypt1"
    // cryptMount "crypt2"
    // { "/media/cryptX" = {
            device = (lib.concatMapStringsSep ":" (d: (toMapper d)) [ 0 1 2 ]);
            fsType = "mergerfs";
            options = [ "defaults" "allow_other" ];
          };
       };

  powerManagement.powerUpCommands = lib.concatStrings (map (disk: ''
      ${pkgs.hdparm}/sbin/hdparm -S 100 ${disk}
      ${pkgs.hdparm}/sbin/hdparm -B 127 ${disk}
      ${pkgs.hdparm}/sbin/hdparm -y ${disk}
    '') allDisks);

  # crypto unlocking
  boot = {
    initrd.luks = {
      devices = let
        usbkey = name: device: {
          inherit name device keyFile;
          keyFileSize = 4096;
          allowDiscards = true;
        };
      in [
        (usbkey "luksroot" rootPartition)
        (usbkey "crypt0" cryptDisk0)
        (usbkey "crypt1" cryptDisk1)
        (usbkey "crypt2" cryptDisk2)
      ];
    };
    loader.grub.device = lib.mkForce rootDisk;

    initrd.availableKernelModules = [
      "ahci"
      "ohci_pci"
      "ehci_pci"
      "pata_atiixp"
      "firewire_ohci"
      "usb_storage"
      "usbhid"
    ];

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  users.users.misa = {
    uid = 9002;
    name = "misa";
  };
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  zramSwap.enable = true;

  krebs.build.host = config.krebs.hosts.omo;
}
