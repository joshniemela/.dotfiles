{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ../../home-manager/zsh.nix # Enable zsh
    ../../home-manager/git.nix # Enable git
    ../../home-manager/xmonad/default.nix # Enable x and xmonad
    # ../../home-manager/i3.nix # Enable x and i3
    ../../home-manager/dunst.nix # Enable dunst
    ../../home-manager/code.nix # Enable vscode and packages
    ../../home-manager/defaultpkgs.nix # Packages across laptop and desktop
    ../../home-manager/nvim/nvim.nix
    ../../modules/julia/default.nix
    ../../modules/fsharp.nix
  ];

  home = {
    packages = with pkgs; [
      font-awesome # Iconscode
      (nerdfonts.override {fonts = ["FiraCode" "Meslo"];}) # Powerline breaks without this
      dmenu
      conda
      ncdu
      docker-compose
      leiningen
      clojure
      openjdk
      insomnia
      nodejs
      prismlauncher
      postgresql
      pass
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
    };
  };
  home.stateVersion = "22.05";
}
