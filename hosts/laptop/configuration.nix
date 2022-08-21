{ config, pkgs, out, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/doas.nix
      ../../modules/pipewire.nix
      ../../modules/thunar.nix
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
    hostName = "laptop"; 
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "192.168.1.1";
    networkmanager.enable = true;
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
  services.blueman.enable = true;
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
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
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
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "1234";
    shell = pkgs.zsh;
  };

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
  };
  system.stateVersion = "22.05";
}

