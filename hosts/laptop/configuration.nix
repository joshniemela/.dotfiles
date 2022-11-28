{ config, pkgs, out, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/doas.nix # enable doas
      ../../modules/pipewire.nix # config for pipewire
      ../../modules/thunar.nix # config for thunar
      ../default/configuration.nix # default host config
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true; 
  };

  networking = {
    hostName = "laptop"; 
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "192.168.1.1";
    networkmanager.enable = true;
  };
  
  zramSwap = {
    enable=true;
    memoryPercent=100;
  };
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver = {
    libinput.enable = true;
    enable = true;
    layout = "dk";
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
  hardware.bluetooth.enable = true;
  
  # PROGRAMS
  programs = {
    git = {
      enable = true;
      config = {
        credential.helper = "cache --timeout=3600";
      };
    };

    iotop.enable = true;
    dconf.enable = true;
    steam.enable = true;
  };

  services.printing.enable = true;

  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "1234";
    shell = pkgs.zsh;
  };

  # Environment
  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw, used for i3
    variables = {
      TERMINAL = [ "alacritty" ];
      EDITOR = [ "vim" ];
    };
  };

  virtualisation = {
    virtualbox.host = {
      enable = false;
    };
  };
}

