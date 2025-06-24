{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = let
    beforeCompInit =
      lib.mkOrder
      550
      ''
        # p10k instant prompt
        local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
        [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

        # Custom completions
        # TODO: get rid of it?
        fpath+=("$XDG_DATA_HOME/zsh/completions")

        # correction
      '';

    afterCompInit = ''
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
  in {
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
      "......" = "../../../../..";
      "......." = "../../../../../..";
    };

    # p10k Home manager config: https://github.com/nix-community/home-manager/issues/1338#issuecomment-651807792
    initContent = lib.mkMerge [
      beforeCompInit
      afterCompInit
    ];
  };
}
