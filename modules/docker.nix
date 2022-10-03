{ config, lib, pkgs, ... }:
{
  users.extraGroups.docker.members = [ "josh" ];
  virtualisation.docker.enable = true;
  environment.systemPackages = [
    pkgs.docker-compose
  ];
}