#
# Doom Emacs: native install with home manager.
# Recommended to comment out this import first install because script will cause issues. It your want to use doom emacs, use the correct location or change in script.
# In my opinion better then nix-community/nix-doom-emacs but more of a hassle to install on a fresh install.
# Unfortunately an activation script like with the default nix options is not possible since home.activation and home.file.*.onChange will time out systemd.
#
# flake.nix
#   ├─ ./hosts
#   │   └─ home.nix
#   └─ ./modules
#       └─ ./editors
#           └─ ./emacs
#               └─ ./doom-emacs
#                   └─ default.nix *
#
{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    DOOM = config.home.homeDirectory + "/.emacs.d"; # Set DOOM env variable to the doom emacs directory
  };
  home = {
    file.".doom.d" = {
      source = ./doom.d;
      recursive = true;
      onChange = builtins.readFile ./doom.sh;
    };

    packages = with pkgs; [
      alacritty # for the doom.sh script
      ripgrep
      coreutils
      fd
      # nix lsp
      nil
      (stdenv.mkDerivation {
        name = "alejandra-posing-as-nixfmt";
        buildInputs = [alejandra];
        phases = ["installPhase"];
        installPhase = ''
          mkdir -p $out/bin
          cat <<EOF > $out/bin/nixfmt
          #!/bin/sh
          exec ${alejandra}/bin/alejandra --quiet "\$@"
          EOF
          chmod +x $out/bin/nixfmt
        '';
      })

    ];
  };
  home.shellAliases = {
    ec = "emacsclient -nc -a ''";
  };
  services.emacs.enable = true;
  programs = {
    emacs.enable = true; # Get Emacs
    emacs.package = pkgs.emacs28NativeComp;
  };
}
