{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home = {
    username = "josh";
    homeDirectory = "/home/josh";
    stateVersion = "22.05";
    packages = with pkgs; [
      neofetch
      lxappearance
      flameshot
      firefox
      mpv
      arandr
      discord
      polymc
      pavucontrol
      alacritty
      thunderbird
      youtube-dl
      gimp
      viewnior
      libreoffice
   ];
  };

  programs = {

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        james-yu.latex-workshop
        bbenoist.nix
        #julialang.julia need to figure out how to add this thing with vs marketplace
      ];
    };

    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        ];
      };
      shellAliases = {
        ll = "ls -l";
        lag = "ls -ag";
        applySystem = "exec ~/.dotfiles/apply-system.sh";
        dir="dir --color='auto'";
        grep="grep --color='auto'";
        unison="unison -ui text";
      };
      initExtra = ''
        bindkey "^[[H" beginning-of-line
        bindkey "^[[F" end-of-line
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        source ~/.config/zsh/.p10k.zsh
      '';
    };
  };
}
  
