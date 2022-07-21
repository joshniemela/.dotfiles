{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/87df845d-2372-46bf-8bc8-fa12c1c04404";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."nixos" = {
    device = "/dev/disk/by-uuid/27d33cb0-1d46-4ae7-8857-7d95cb188932";
    allowDiscards = true;
    bypassWorkqueues = true;
  };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/87df845d-2372-46bf-8bc8-fa12c1c04404";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/87df845d-2372-46bf-8bc8-fa12c1c04404";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7ADB-7CEC";
      fsType = "vfat";
    };

  fileSystems."/run/media/josh/backup" =
    { device = "/dev/disk/by-uuid/0c90ce97-15e6-4301-955b-c9d89e3d763d";
      fsType = "xfs";
    };

  boot.initrd.luks.devices."backup".device = "/dev/disk/by-uuid/2461596d-59b8-4f88-972d-245590944472";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp9s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
