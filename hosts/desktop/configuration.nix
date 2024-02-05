{
  lib,
  config,
  pkgs,
  out,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/thunar.nix
    ../../modules/pipewire.nix
    ../../modules/doas.nix
    ../default/configuration.nix # default host config
    ../../modules/docker.nix
    ../../modules/virtualbox.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "desktop";
    nameservers = ["8.8.8.8"];
    defaultGateway = "192.168.1.1";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.3";
        prefixLength = 24;
      }
    ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  services.xserver = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
    };
    layout = "dk";
    videoDrivers = ["nvidia"];

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+xmonad";
      autoLogin = {
        enable = true;
        user = "josh";
      };
    };
  };
  networking.firewall.enable = false;

  # PROGRAMS
  programs = {
    iotop.enable = true;
    dconf.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };
  users.extraGroups.vboxusers.members = ["josh"];
  services.printing.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;
  users.users.josh = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "1234";
    shell = pkgs.zsh;
  };

  # Environment
  environment = {
    pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw, used for i3
    variables = {
      TERMINAL = ["kitty"];
      EDITOR = ["vim"];
    };
  };
}
