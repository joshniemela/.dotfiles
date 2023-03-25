{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
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
    };
    initExtra = ''
      bindkey "^[[3~" delete-char
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      source $HOME/.dotfiles/configs/p10k
    '';
  };
}
