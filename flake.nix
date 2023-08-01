{
  description = "Josh's NixOS flake";
  inputs = {
    nixpkgs-small.url = "github:NixOs/nixpkgs/nixos-unstable-small";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    webcord.url = "github:fufexan/webcord-flake"; # foss discord

    tex2nix.url = "github:Mic92/tex2nix";
    zig.url = "github:mitchellh/zig-overlay";
    copilot-el = {
      url = "github:zerolfx/copilot.el";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-small,
    nixpkgs-stable,
    flake-utils,
    home-manager,
    webcord,
    tex2nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    lib-small = nixpkgs-small.lib;
    overlays = [
      inputs.zig.overlays.default

      # This overlay exists to fix the ABI version of tree-sitter-python
      (final: prev: {
        tree-sitter-grammars =
          prev.tree-sitter-grammars
          // {
            tree-sitter-python = prev.tree-sitter-grammars.tree-sitter-python.overrideAttrs (_: {
              nativeBuildInputs = [final.nodejs final.tree-sitter];
              configurePhase = ''
                tree-sitter generate --abi 13 src/grammar.json
              '';
            });
          };
      })
    ];
  in {
    nixosConfigurations = {
      server = lib-small.nixosSystem {
        inherit system;
        modules = [
          ./hosts/server/configuration.nix
        ];
      };

      liveISO = lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/iso.nix
        ];
      };

      desktop = lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          ./hosts/desktop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.josh = {...}: {
                imports = [
                  ./hosts/desktop/josh.nix
                ];
              };
              #FIXME: this shouldnt be called flakes
              extraSpecialArgs = {flakes = inputs;};
            };
          }
        ];
      };
      laptop = lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          ./hosts/laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = overlays;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.josh = import ./hosts/laptop/josh.nix;
              extraSpecialArgs = inputs;
            };
          }
        ];
      };
    };
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
