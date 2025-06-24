{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    zplug = {
      enable = true;
      plugins = [
        {
          name = "romkatv/powerlevel10k";
          tags = [as:theme depth:1];
        }
      ];
    };
    shellAliases = {
      ll = "ls -l";
      lag = "ls -ag";
      ls = "ls --color='always'";
      grep = "grep --color='always'";
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
    };

    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"

      # Powerlevel10k config
      typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=
      typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

      if [[ -f $XDG_DATA_HOME/zsh/zshrc ]]; then source $XDG_DATA_HOME/zsh/zshrc; fi

      # other nice things
      bindkey "^[[3~" delete-char
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      source $HOME/.dotfiles/configs/p10k
    '';
  };
}
