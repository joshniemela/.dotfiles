{
  pkgs,
  modulesPath,
  config,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking = {
    hostName = "liveUSB";
    nameservers = ["8.8.8.8"];
  };

  # in case of proprietary wireless drivers
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = ["wl"];
  boot.extraModulePackages = [config.boot.kernelPackages.broadcom_sta];
  boot.initrd.kernelModules = ["wl"];

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
    useXkbConfig = false;
  };

  users.users.josh = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];

    initialPassword = "1234";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkFDwJpcAKRArAOvx/fT2J5clly89NYFIdcWUVsxGRw josh@desktop"];
  };

  environment.systemPackages = with pkgs; [
    doas
    git
    wget
    nixFlakes
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking = {
    firewall.enable = false;
    wireless.enable = false;
    networkmanager.enable = true;
  };

  # doas config
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          persist = true;
          keepEnv = true;
        }
      ];
    };
  };
}
