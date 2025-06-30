{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
  ];
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
    nixpkgs = {
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "electron-27.3.11"
      ];
    };

    hardware = lib.mkMerge [
      (lib.mkIf (!config.dotfiles.headless) {graphics.enable = true;})
      {enableRedistributableFirmware = true;}
    ];
    systemd = {
      services.clear-log = {
        description = "Clear logs older than two weeks";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=14d";
        };
      };

      timers.clear-log = {
        wantedBy = ["timers.target"];
        partOf = ["clear-log.service"];
        timerConfig.OnCalendar = "weekly UTC";
      };
    };

    i18n.defaultLocale = lib.mkDefault "en_DK.UTF-8";
    console = lib.mkMerge [
      (lib.mkIf config.dotfiles.headless {keyMap = "dk";})
      (lib.mkIf (!config.dotfiles.headless) {useXkbConfig = true;})
      {font = lib.mkDefault "Lat2-Terminus16";}
    ];

    time.timeZone = lib.mkDefault "Europe/Copenhagen";
    system.stateVersion = "22.05";
    programs = {
      git.enable = true;
      nix-ld.enable = true;

      gnupg.agent = {
        enable = true;
        # this no longer works
        #pinentryFlavor = "curses";
        enableSSHSupport = true;
      };
    };
    services.pcscd.enable = true;

    services.autorandr = {
      enable = true;
    };

    environment.defaultPackages = [
      pkgs.perl
      pkgs.strace
      pkgs.linuxPackages_latest.perf
      pkgs.doas-sudo-shim

      (pkgs.writeShellScriptBin "switchSystem" ''
        set -e
        pushd $HOME/.dotfiles
        sudo nixos-rebuild switch --use-remote-sudo --flake .#
        popd
      '')

      (pkgs.writeShellScriptBin "testSystem" ''
        set -e
        pushd $HOME/.dotfiles
        sudo nixos-rebuild test --use-remote-sudo --flake .#
        popd
      '')

      (pkgs.writeShellScriptBin "updateSystem" ''
        set -e
        pushd $HOME/.dotfiles
        doas nix flake update
        popd
      '')

      (pkgs.writeShellScriptBin "buildISO" ''
        set -e
        pushd $HOME/.dotfiles
        nix build .#nixosConfigurations.liveISO.config.system.build.isoImage
        popd
      '')
    ];
  };
}
