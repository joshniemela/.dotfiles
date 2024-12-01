{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  users.users.josh.extraGroups = ["libvirtd"];
}
