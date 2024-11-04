{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["ehci_pci" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d1bfbeb6-e691-4d59-abef-0590d72f46c5";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd" "discard"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/d1bfbeb6-e691-4d59-abef-0590d72f46c5";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd" "discard"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d1bfbeb6-e691-4d59-abef-0590d72f46c5";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd" "noatime" "discard"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CB08-1791";
    fsType = "vfat";
  };

  fileSystems."/storage" = {
    device = "/dev/disk/by-uuid/199caee7-58dc-4d6d-9dfc-453eae89c769";
    fsType = "btrfs";
    options = [ "subvol=first" "compress=zstd" ];
  };

  fileSystems."/backup" = { 
    device = "/dev/disk/by-uuid/4a694e66-e6fe-4dfb-a495-f2bd8cea947f";
    fsType = "btrfs";
    options = [ "subvol=first" "compress=zstd" ];
  };


  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
