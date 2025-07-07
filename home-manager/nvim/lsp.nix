{
  pkgs,
  lib,
  ...
}:
{
  programs.nvf.settings.vim = {
    diagnostics = {
      enable = true;
      config.virtual_lines = true;

      nvim-lint = {
        enable = true;
      };
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lightbulb.enable = true;
      lspSignature.enable = true;
      trouble.enable = true;
      nvim-docs-view.enable = true;
      inlayHints.enable = true;

      # Black magic needed because nil is not accepting autoarchive argument
      # in nvf
      lspconfig.sources.nix-lsp = lib.mkForce ''
        lspconfig.nil_ls.setup{
          capabilities = capabilities,
          on_attach = default_on_attach,
          cmd = {"${lib.getExe pkgs.nil}"},
          settings = {
            ["nil"] = {
              formatting = {
                command = {"${lib.getExe pkgs.nixfmt-rfc-style}"},
              },
            },
            ["nix"] = {
              flake = {
                autoArchive = true,
              },
            },
          },
        }
      '';
    };

    debugger = {
      nvim-dap.enable = true;

      nvim-dap.ui = {
        enable = true;
        autoStart = true;
      };
    };

    languages = {
      lua.enable = true;
      nix.enable = true;
      sql.enable = true;
      ts.enable = true;
      svelte.enable = true;
      tailwind.enable = true;
      html.enable = true;
      css.enable = true;
      bash.enable = true;
      python.enable = true;
      markdown.enable = true;
      rust.enable = true;
      haskell.enable = true;

      enableTreesitter = true;
      enableFormat = true;
      enableExtraDiagnostics = true;
    };

    spellcheck = {
      enable = true;
      programmingWordlist.enable = true;
    };

    treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      typescript # in language settings only tsx gets enabled, not typescript
    ];

    git.enable = true;
  };
}
