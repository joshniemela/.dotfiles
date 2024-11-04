{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuSwtpm = true;
  };

  programs.virt-manager.enable = true;
  users.users.josh.extraGroups = ["libvirtd"];
}
