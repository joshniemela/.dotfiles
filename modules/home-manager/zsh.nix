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
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
      shellAliases = {
        ll = "ls -l";
        lag = "ls -ag";
        switchSystem = "source ~/.dotfiles/switchSystem.sh";
        testSystem = "source ~/.dotfiles/testSystem.sh";
        updateSystem = "source ~/.dotfiles/updateSystem.sh";
        ls="ls --color='always'";
        grep="grep --color='always'";
        unison="unison -ui text";
        "..."="../..";
      };
      initExtra = ''
        bindkey "^[[3~" delete-char
        bindkey "^[[H" beginning-of-line
        bindkey "^[[F" end-of-line
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        source ~/.dotfiles/configs/p10k
      '';
    };
}
