{pkgs, flakes,...}: {
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackagesOverlay = self: super: {
      copilot = self.trivialBuild {
        pname = "copilot";
        ename = "copilot";
        version = "0.0.0";
        buildInputs = [self.s self.dash self.editorconfig self.jsonrpc];
        src = flakes.copilot-el;
        extraPackages = [pkgs.nodejs];
        extraConfig = ''
          (setq copilot-node-executable = "${pkgs.nodejs}/bin/node")
          (setq copilot--base-dir = "${flakes.copilot-el}")
        '';
        installPhase = ''
          runHook preInstall
          LISPDIR=$out/share/emacs/site-lisp
          install -d $LISPDIR
          cp -r * $LISPDIR
          runHook postInstall
        '';
      };
    };
  };
  services.emacs.enable = true;
  home.packages = with pkgs; [
    nodePackages.pyright
    #tree-sitter
  ];
}
