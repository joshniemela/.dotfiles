{
  config,
  pkgs,
  out,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/doas.nix # enable doas
    ../../modules/pipewire.nix # config for pipewire
    ../../modules/thunar.nix # config for thunar
    ../default/configuration.nix # default host config
    ../../modules/docker.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "laptop";
    nameservers = ["8.8.8.8"];
    #defaultGateway = "192.168.1.1";
    networkmanager.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;

    thermald.enable = true;
  };

  services.tlp = {
    settings = {
      CPU_BOOST_ON_AC = 1;

      CPU_BOOST_ON_BAT = 0;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  services.xserver = {
    libinput.enable = true;
    enable = true;
    layout = "dk";
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "josh";
      };
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
  hardware.bluetooth.enable = true;

  # PROGRAMS
  programs = {
    zsh.enable = true;
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
    extraGroups = ["wheel" "networkmanager"];
    initialPassword = "1234";
    shell = pkgs.zsh;
  };

  # Environment
  environment = {
    pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw, used for i3
    variables = {
      TERMINAL = ["alacritty"];
      EDITOR = ["vim"];
    };
  };
}
