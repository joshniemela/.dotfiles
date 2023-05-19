{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;
  imports = [
    ../../modules/home-manager/zsh.nix # Enable zsh
    ../../modules/home-manager/git.nix # Enable git
    ../../modules/home-manager/xmonad/default.nix
    ../../modules/home-manager/dunst.nix # Enable dunst
    ../../modules/home-manager/code.nix # Enable code
    ../../modules/home-manager/defaultpkgs.nix # Packages across laptop and desktop
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
      enable = true;
      profiles = import ../../modules/home-manager/autorandr/laptop.nix;
    };
    home-manager.enable = true;

    firefox = {
      enable = true;
      profiles = import ../../modules/home-manager/firefox.nix;
    };
  };
  home.stateVersion = "22.05";
}
