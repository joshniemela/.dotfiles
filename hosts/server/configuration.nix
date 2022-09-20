{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ../../modules/website.nix
      ../../modules/doas.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  systemd = {
    services.clear-log = {
      description = "Clear logs older than two weeks";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=14d";
      };
    };
    timers.clear-log = {
      wantedBy = [ "timers.target" ];
      partOf = [ "clear-log.service" ];
      timerConfig.OnCalendar = "weekly UTC";
    };
  };
  # Use the systemd-boot EFI boot loader, replace with grub for BIOS based systems.
  boot = {
    kernelPackages = pkgs.linuxPackages_5_18_hardened;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "server"; 
    domain = "jniemela.dk";
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "192.168.1.1";
    interfaces.eth0.ipv4.addresses = [{
      address="192.168.1.2";
      prefixLength = 24;
    }];
    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 42069 25565 80 443 ];
      allowedUDPPorts = [ 19132 34197 ];
      enable = true;
    };

  };
  
 services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "127.0.0.0/8" 
      "10.0.0.0/8" 
      "172.16.0.0/12" 
      "192.168.0.0/16"
      "8.8.8.8"
    ];
  };

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };

  zramSwap = {
    enable=true;
    memoryPercent=100;
  };

  users = {
    users.josh = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ]; 
      initialPassword = "1234";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkFDwJpcAKRArAOvx/fT2J5clly89NYFIdcWUVsxGRw josh@josharch" ];
      shell = pkgs.zsh;
    };
  };
 
  environment.systemPackages = with pkgs; [
    nano
    unison
    docker-compose
    cryptsetup
  ];
  services = {
    openssh.enable = true;
    smartd.enable = true;
  };

  virtualisation.docker.enable = true;
  
  system.stateVersion = "22.05";
}

