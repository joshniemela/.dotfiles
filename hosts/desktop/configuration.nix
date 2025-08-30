{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/thunar.nix
    ../../modules/pipewire.nix
    ../../modules/doas.nix
    ../default/configuration.nix # default host config
    ../../modules/docker.nix
    ../../modules/virtmanager.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "desktop";
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "192.168.1.1";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.3";
        prefixLength = 24;
      }
    ];

    firewall = rec {

      # Used by kdeconnect
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;

      enable = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };

  services = {
    displayManager.autoLogin = {
      enable = true;
      user = "josh";
    };

    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
      };
      xkb.layout = "dk";

      displayManager.lightdm.enable = true;
    };

    displayManager.defaultSession = "none+xmonad";
    printing.enable = true;
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;

    # Put this into a separate module
    postgresql = {
      enable = true;

      extensions = with pkgs.postgresql_16.pkgs; [ pgvector ];
      package = pkgs.postgresql_16;
    };
  };

  # PROGRAMS
  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };

    iotop.enable = true;
    dconf.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };

  users = {
    extraGroups.vboxusers.members = [ "josh" ];
    users.josh = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "1234";
      shell = pkgs.zsh;
    };
  };

  # Environment
  environment = {
    pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw, used for i3
    variables = {
      TERMINAL = [ "kitty" ];
      EDITOR = [ "vi" ];
    };
  };
}
