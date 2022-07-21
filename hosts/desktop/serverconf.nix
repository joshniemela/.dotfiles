# systemEdit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
      partOf = ["clear-log.service" ];
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
    interfaces.eth0.ipv4.addresses = [ {
      address="192.168.1.2";
      prefixLength = 24;
    } ];

    firewall = {
      allowedTCPPorts = [ 42069 25565 ];
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
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
    };
    users.peter = {
      isNormalUser = true;
      extraGroups = [ "docker" ]; 

      initialPassword = "1234";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFykQFb2WstNq1Iv1KL3spNY3Y6udyuk6F0hmbFvKN2r user@deepthought "];
    };

    users.temp = {
      isNormalUser = true; 

      initialPassword = "1234";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOu8/uo3T9syxIECxpteIGuk4XxBD29y5cfC2g+Udfx MacSlash "];
    };
  };
 
  environment.systemPackages = with pkgs; [
    nano
    wget
    docker
    doas
    unison
    docker-compose
    cryptsetup
  ];

  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  # Open ports in the firewall.

  # Doas config
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ]; 
        persist = true;
	keepEnv = true;
	}];
    };
  };

  system.stateVersion = "22.05";
}

