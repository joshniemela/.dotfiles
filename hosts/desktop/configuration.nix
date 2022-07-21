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
  
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true; 
  };

  networking = {
    hostName = "desktop"; 
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "192.168.1.1";
    interfaces.eth0.ipv4.addresses = [ {
      address="192.168.1.3";
      prefixLength = 24;
    } ];
  };

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
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
       dunst
       feh 
       i3status
      ];
    };
  };
  hardware.opengl.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "1234";
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    #SYSTEM TOOLS
    wget
    git
    htop
    neofetch
    unison
    julia-bin
    #PYTHON
    (let 
      my-python-packages = python-packages: with python-packages; [ 
        pandas
        scipy
        matplotlib
        pyarrow
        numpy
        scikitlearn
      ];
      python-with-my-packages = python3.withPackages my-python-packages;
      in
      python-with-my-packages
    )
  ];
  environment.pathsToLink = [ "/libexec" ];

  security = {
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
  programs.steam.enable = true;
  system.stateVersion = "22.05";
}

