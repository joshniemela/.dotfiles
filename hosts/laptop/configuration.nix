
{ config, pkgs, out, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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
    #interfaces.eth0.ipv4.addresses = [ {
    #  prefixLength = 24;
    #} ];
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
  
  services.xserver = {
    libinput.enable = true;
    #synaptics.enable = true;
    enable = true;
    layout = "dk";
    #videoDrivers = [ "nvidia" ];
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+qtile";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "josh";
      };
    };
    
    windowManager.qtile = {
      enable = true;
      #extraPackages = with pkgs; [
      # dmenu
      # i3status
      #];
    };
  };
  hardware.opengl = {
    enable = true;
    # driSupport32Bit = true;
  };
  # PROGRAMS
  programs = {
    nix-ld.enable = true; # Dynamic binaries for Julia
    git.enable = true;    
    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
        show_cpu_frequency = true;
        show_cpu_temperature = true;
      };
    };
    iotop.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
      };

    dconf.enable = true;
    steam.enable = true;
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    printing.enable = true;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
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
      EDITOR = [ "codium" ];
      };
    
  };
  
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [ {
        groups = [ "wheel" ]; 
        persist = true;
	      keepEnv = true;
	    } ];
    };
  };

  virtualisation = {
    virtualbox.host = {
      enable = true;
    };
    docker = {
      enableNvidia = true;
      enable = false;
    }; 
  };
  system.stateVersion = "22.05";
}

