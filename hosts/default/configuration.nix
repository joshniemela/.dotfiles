{ config, lib, pkgs, ...}:
{
  options.dotfiles = {
    headless = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to run the headless version of the dotfiles.
      '';
    };
  };
  config = {
    nix = {
      package = pkgs.nixVersions.stable;
      extraOptions = "experimental-features = nix-command flakes";
      gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
    };
    nixpkgs.config.allowUnfree = true;

    hardware = lib.mkMerge [
      (lib.mkIf (!config.dotfiles.headless) { opengl.enable = true; })
      {enableRedistributableFirmware = true;}
    ];
    #hardware.enableAllFirmware = true;
    
    systemd = {
      services.clear-log = {
        description = "Clear logs older than two weeks";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=14d";
        };
      };
      
      timers.clear-log = {
        wantedBy = [ "timers.target" ];
        partOf = [ "clear-log.service" ];
        timerConfig.OnCalendar = "weekly UTC";
      };
    };

    i18n.defaultLocale = lib.mkDefault "en_DK.UTF-8";
    console = lib.mkMerge [
      (lib.mkIf config.dotfiles.headless { keyMap = "dk"; })
      (lib.mkIf (!config.dotfiles.headless) { useXkbConfig = true; })
      {font = lib.mkDefault "Lat2-Terminus16";}
    ];

    time.timeZone = lib.mkDefault "Europe/Copenhagen";
    system.stateVersion = "22.05";
  };
}