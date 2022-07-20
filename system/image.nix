{ pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "liveUSB"; # Define your hostname.
    nameservers = [ "8.8.8.8" ];
  };

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
    useXkbConfig = false;
  };

  users.users.josh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];

    initialPassword = "1234";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkFDwJpcAKRArAOvx/fT2J5clly89NYFIdcWUVsxGRw josh@josharch"];
  };

  environment.systemPackages = with pkgs; [
    doas
    git
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking = {
    firewall.enable = false;
    wireless.enable = false;
    networkmanager.enable = true;
  };
  
  #doas config
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

  #system.stateVersion = "22.05"; 
}

