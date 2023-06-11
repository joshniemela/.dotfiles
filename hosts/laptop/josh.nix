{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;
  imports = [
    ../../home-manager/zsh.nix # Enable zsh
    ../../home-manager/git.nix # Enable git
    ../../home-manager/xmonad/default.nix
    ../../home-manager/dunst.nix # Enable dunst
    ../../home-manager/code.nix # Enable code
    ../../home-manager/defaultpkgs.nix # Packages across laptop and desktop
    ../../modules/julia/default.nix # Julia
    ../../modules/fsharp.nix
    ../../modules/home-manager/nvim/nvim.nix
  ];

  home = {
    packages = with pkgs; [
      font-awesome # Icons
      (nerdfonts.override {fonts = ["FiraCode" "Meslo"];}) # Powerline breaks without this
      brightnessctl # Brightness control
      dmenu
      openjdk
      clojure
      leiningen
      insomnia
      docker-compose

      (pkgs.writeShellScriptBin "disableKeyboard" ''
        xinput float "AT Translated Set 2 keyboard"
      '')

      (pkgs.writeShellScriptBin "enableKeyboard" ''
        xinput reattach "AT Translated Set 2 keyboard" "Virtual core keyboard"
      '')
    ];
  };

  programs = {
    autorandr = {
      enable = false;
      # profiles =
    };
    home-manager.enable = true;

    firefox = {
      enable = true;
      profiles = import ../../home-manager/firefox.nix;
    };
  };
  home.stateVersion = "22.05";
}
