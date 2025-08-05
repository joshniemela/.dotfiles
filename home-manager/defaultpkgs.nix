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

      # disabled because it depends on libsoup 2 which has vulnerabilities
      #darktable # photo editor
      lxappearance # for changing gtk theme
      typst # for writing
      chromium
      imagemagick # Used for conversion of image formats
      ffmpeg # for converting videos
      xclip # for copying to clipboard

      simplescreenrecorder
      zip # for compressing files
      unzip # for uncompressing files
      bat # better cat
      btop # better htop

      wget
      xorg.xev
      pandoc
      inkscape
      shellcheck

      # work
      remmina

      pass
    ];
  };
  services.flameshot.enable = true;

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
