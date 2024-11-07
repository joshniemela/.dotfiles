{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf.enable = true;
    qemuSwtpm.enable = true;
  };

  programs.virt-manager.enable = true;
  users.users.josh.extraGroups = ["libvirtd"];
}
