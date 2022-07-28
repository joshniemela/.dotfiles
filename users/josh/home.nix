{ config, pkgs, ...}:

{
  programs.home-manager.enable = true;
  home = {
    file = {
      ".unison/default.prf".source  = ../../configs/default.prf;
    };
    packages = with pkgs; [
      neofetch
      lxappearance
      discord
      polymc
      pavucontrol
      thunderbird
      youtube-dl
      gimp
      viewnior
      libreoffice
      unison
      tree
      texlive.combined.scheme-full
      docker-compose
   ];
  };
  services = {
    flameshot.enable = true;
    easyeffects.enable = true;

    dunst = {
      enable = true;
      settings = import ../../modules/home-manager/dunst.nix;
    };
  };
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    autorandr = {
      enable = true;
      profiles = import ../../modules/home-manager/autorandr/desktop.nix;
    };

    mpv = { 
      enable = true; 
    };

    firefox = { 
      enable = true; 
      /* profiles.default = {
        id = 0;
        name = "Default";
        settings = {
          # Enable HTTPS-Only Mode
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;

          # Privacy settings
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.partition.network_state.ocsp_cache" = true;

          # Disable all sorts of telemetry
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # As well as Firefox 'experiments'
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "network.allow-experiments" = false;

          # Disable Pocket Integration
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = "";
          "extensions.pocket.oAuthConsumerKey" = "";
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = "";
        };
      };
      */
    };

    alacritty = {
      enable = true;
    };
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
        applySystem = "source ~/.dotfiles/apply-system.sh";
        dir="dir --color='auto'";
        grep="grep --color='auto'";
        unison="unison -ui text";
      };
      initExtra = ''
        bindkey "^[[H" beginning-of-line
        bindkey "^[[F" end-of-line
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word
        source .dotfiles/./configs/p10k.zsh
      '';
    };
    
  };
  xsession = {
    enable = true;
    windowManager = {
      i3 = {
        enable = true;
        
        config = import ../../modules/home-manager/i3.nix { 
          inherit pkgs; 
          mod = "Mod1"; # Set to Mod1 for alt, Mod4 for super
        };
      };
    };
  };
  home.stateVersion = "22.05";
}
  
