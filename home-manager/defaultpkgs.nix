{
  pkgs,
  ...
}:
{
  home = {
    file.".unison/default.prf".source = ../configs/unison.prf; # File used for unison, TODO MAKE MODULE
    packages = with pkgs; [
      discord

      prismlauncher # minecraft launcher

      jq
      cmake
      gnumake
      nodejs
      fastfetch # system info
      unison # for syncing
      libreoffice # office suite
      viewnior # image viewer
      gimp # image editor
      pavucontrol # audio control
      xournalpp # for signing pdfs
      tree # for viewing directory structure

      typst # for writing
      chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos

      simplescreenrecorder
      zip # for compressing files
      unzip # for uncompressing files
      bat # better cat
      btop # better htop
      thunderbird

      wl-clipboard

      wget
      xorg.xev
      pandoc
      inkscape
      shellcheck

      # work
      remmina

      vintagestoryPackages.latest

      pass
    ];
  };

  programs = {
    tmux = {
      enable = false;
      clock24 = true;
    };

    zathura.enable = true;

    htop = {
      enable = true;
      settings = {
        hide_kernel_threads = true;
        hide_userland_threads = true;
        show_cpu_frequency = true;
        show_cpu_temperature = true;
      };
    };
    mpv.enable = true;
    kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font";
        package = pkgs.fira-code;
      };
      settings = {
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
