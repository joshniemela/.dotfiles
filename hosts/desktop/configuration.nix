# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "desktop"; 
    #domain = "jniemela.dk"; 
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
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };
  zramSwap = {
    enable=true;
    memoryPercent=100;
  };

  # Configure keymap in X11
  
  services.xserver = {
    enable = true;
    layout = "dk";
    videoDrivers = [ "nvidia" ];
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      #startx.enable = true;
      defaultSession = "none+i3";
    };
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
       dmenu 
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
  # services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "1234";
    packages = with pkgs; [
      firefox
      thunderbird
      alacritty
      pavucontrol
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
    neofetch
    unison
    lxappearance
    vscodium
    viewnior
    discord
  ];
  environment.pathsToLink = [ "/libexec" ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
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
  system.stateVersion = "22.05"; # Did you read the comment?

}

