{ config, pkgs, out, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/thunar.nix
      ../../modules/pipewire.nix
      ../../modules/doas.nix
    ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true; 
  };

  networking = {
    hostName = "desktop"; 
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "192.168.1.1";
    interfaces.eth0.ipv4.addresses = [{
      address="192.168.1.3";
      prefixLength = 24;
    }];
  };

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  zramSwap = {
    enable=true;
    memoryPercent=100;
  };
  
  services.xserver = {
    enable = true;
    layout = "dk";
    videoDrivers = [ "nvidia" ];
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "josh";
      };
    };
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
       dmenu
      ];
    };
  };
  hardware.opengl = {
    enable = true;
    # driSupport32Bit = true;
  };
  # PROGRAMS
  programs = {
    git.enable = true;    
    iotop.enable = true;

    dconf.enable = true;
    steam.enable = true;
  };

  services.printing.enable = true;
  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "1234";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    # SYSTEM TOOLS
    wget
    neofetch
  ];

  # Environment
  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw, used for i3
    variables = {
      TERMINAL = [ "alacritty" ];
      EDITOR = [ "code" ];
      };
    
  };
  virtualisation = {
    virtualbox.host = {
      enable = true;
    };
    docker = {
      enableNvidia = true;
      enable = true;
    }; 
  };
  system.stateVersion = "22.05";
}

