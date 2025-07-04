{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = true; # why is this needed? (laptop)
  imports = [
    ../../home-manager/zsh.nix # Enable zsh
    ../../home-manager/git.nix # Enable git
    ../../home-manager/xmonad/default.nix # Enable x and xmonad
    # ../../home-manager/i3.nix # Enable x and i3
    ../../home-manager/dunst.nix # Enable dunst
    # ../../home-manager/code.nix # Enable vscode and packages emacs is my friend now
    ../../home-manager/defaultpkgs.nix # Packages across laptop and desktop
    ../../home-manager/nvim/nvim.nix
    #../../home-manager/emacs
    ../../home-manager/languages/julia/default.nix
    ../../home-manager/languages/dotnet.nix
    ../../home-manager/languages/rust.nix
  ];

  home = {
    packages = with pkgs; [
      font-awesome # Iconscode
      # p10k breaks without these fonts
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      dmenu
      ncdu
      insomnia
      brightnessctl

      firefox-devedition
      vivaldi
    ];
  };
  services = {
    easyeffects.enable = false;
  };

  programs = {
    nushell.enable = true;

    home-manager.enable = true;
  };

  home.stateVersion = "22.05";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
