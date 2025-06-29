{
  config,
  pkgs,
  out,
  ...
} @ args: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/doas.nix # enable doas
    ../../modules/pipewire.nix # config for pipewire
    ../../modules/thunar.nix # config for thunar
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
    hostName = "thonkpad";
    nameservers = ["8.8.8.8"];
    networkmanager.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 15;
  };
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    thermald.enable = true;

    # Make a udev rule to detach and connect keyboard and detach with xinput
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="input", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/josh/.Xauthority", ATTRS{idVendor}=="3233", ATTRS{idProduct}=="6301", RUN+="${pkgs.xorg.xinput}/bin/xinput float 'AT Translated Set 2 keyboard'"
      ACTION=="remove", SUBSYSTEM=="input", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/josh/.Xauthority", ATTRS{idVendor}=="3233", ATTRS{idProduct}=="6301", RUN+="${pkgs.xorg.xinput}/bin/xinput reattach 'AT Translated Set 2 keyboard' 'Virtual core keyboard'"
    '';
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;

      CPU_BOOST_ON_BAT = 0;

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  services.libinput.enable = true;
  services.fwupd.enable = true;

  services.displayManager = {
    defaultSession = "none+xmonad";
    autoLogin = {
      enable = true;
      user = "josh";
    };
  };

  services.xserver = {
    enable = true;
    xkb.layout = "dk";
    desktopManager = {
      xterm.enable = false;
    };

    displayManager.lightdm.enable = true;

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
      TERMINAL = ["kitty"];
      EDITOR = ["vi"];
      DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };
  };

  systemd.timers."battery-notifier" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
      Unit = "battery-notifier.service";
    };
  };

  systemd.services.battery-notifier = {
    environment = {
      DISPLAY = ":0";
      DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
    };
    script = ''
      battery_result=$(${pkgs.acpi}/bin/acpi -b)

      battery_percent=$(echo $battery_result | grep -Eo '[0-9]+%' | sed 's/%//')

      battery_remaining=$(echo $battery_result | grep -Eo '[0-9]+:[0-9]+:[0-9]+')

      battery_status=$(echo $battery_result | grep -Eio 'remaining|charged')


      if [ "$battery_status" == "remaining" ]; then
          if [ $battery_percent -le 35 ] && [ $battery_percent -gt 25 ]; then
              ${pkgs.dunst}/bin/dunstify -a system -t 9000 -r 1337 -u normal "Low battery" "$battery_percent% remaining\n $battery_remaining"

          elif [ $battery_percent -le 25 ] && [ $battery_percent -gt 15 ]; then
              ${pkgs.dunst}/bin/dunstify -a system -t 9000 -r 1337 -u critical "Low battery" "$battery_percent% remaining\n $battery_remaining"

          elif [ $battery_percent -le 15 ]; then
              ${pkgs.dunst}/bin/dunstify -a system -t 9000 -r 1337 -u low "CRITICALLY LOW BATTERY" "$battery_percent% remaining\n $battery_remaining"
          fi
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "josh";
    };
  };
}
