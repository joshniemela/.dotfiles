{
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
    ../../home-manager/emacs
    ../../home-manager/languages/julia/default.nix
    ../../home-manager/languages/fsharp.nix
    ../../home-manager/languages/clojure.nix
    ../../home-manager/languages/zig.nix
  ];

  home = {
    packages = with pkgs; [
      font-awesome # Iconscode
      (nerdfonts.override {fonts = ["FiraCode" "Meslo"];}) # Powerline breaks without this
      dmenu
      conda
      ncdu
      insomnia
      nodejs
      prismlauncher

      # laptop
      (pkgs.writeShellScriptBin "disableKeyboard" ''
        xinput float "AT Translated Set 2 keyboard"
      '')

      (pkgs.writeShellScriptBin "enableKeyboard" ''
        xinput reattach "AT Translated Set 2 keyboard" "Virtual core keyboard"
      '')
      brightnessctl
      # end laptop

    ];
  };
  services = {
    easyeffects.enable = true;
  };

  programs = {
    home-manager.enable = true;
    autorandr = {
      enable = true;
      profiles = import ../../home-manager/autorandr/desktop.nix;
    };

    firefox = {
      enable = true;
      #profiles = import ../../home-manager/firefox.nix; # (laptop)
    };
  };
  home.stateVersion = "22.05";
}
