{
  config,
  pkgs,
  lib,
  ...
}: {
  dotfiles.headless = true; # Sets all modules to use the headless version, if available
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ../../modules/website.nix
    ../../modules/doas.nix
    ../../modules/docker.nix
    ../default/configuration.nix # default configs for host
  ];

  # Use the systemd-boot EFI boot loader, replace with grub for BIOS based systems.
  boot = {
    kernelPackages = pkgs.linuxPackages_5_15_hardened;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "server";
    domain = "jniemela.dk";
    nameservers = ["8.8.8.8"];
    defaultGateway = "192.168.1.1";
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.2";
        prefixLength = 24;
      }
    ];
    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [42069 25565 80 443];
      allowedUDPPorts = [19132 34197];
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

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  programs = {
    git.enable = true;
    tmux.enable = true;
    zsh.enable = true;
  };

  users = {
    users.josh = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # TODO add docker group to docker.nix
      initialPassword = "1234";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkFDwJpcAKRArAOvx/fT2J5clly89NYFIdcWUVsxGRw josh@desktop"];
      shell = pkgs.zsh;
    };

    users.jakupl = {
      isNormalUser = true;
      initialPassword = "1234";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkFDwJpcAKRArAOvx/fT2J5clly89NYFIdcWUVsxGRw josh@desktop"];
      shell = pkgs.zsh;
    };

    users.kristiandampedersen = {
      isNormalUser = true;
      initialPassword = "1234";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkFDwJpcAKRArAOvx/fT2J5clly89NYFIdcWUVsxGRw josh@desktop"];
      shell = pkgs.zsh;
    };
  };

  #powerManagement = {
  #  enable = true;
  #  cpuFreqGovenor = "powersave";
  #};

  environment.systemPackages = with pkgs; [
    unison
    cryptsetup
    vim
    screen
  ];
  services = {
    openssh.enable = true;
    smartd.enable = true;
  };
}
