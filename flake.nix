{
  description = "Josh's NixOS flake";
  inputs = {
    nixpkgs-small.url = "github:NixOs/nixpkgs/nixos-unstable-small";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";

    webcord.url = "github:fufexan/webcord-flake"; # foss discord

    tex2nix.url = "github:Mic92/tex2nix";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    copilot-el = {
      url = "github:zerolfx/copilot.el";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";

    vintagestory-nix = {
      url = "github:PierreBorine/vintagestory-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-small,
      nixpkgs-stable,
      home-manager,
      webcord,
      tex2nix,
      flake-parts,
      zig-overlay,
      vintagestory-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      overlays = [
        zig-overlay.overlays.default

        vintagestory-nix.overlays.default

        # This overlay exists to fix the ABI version of tree-sitter-python
        (final: prev: {
          tree-sitter-grammars = prev.tree-sitter-grammars // {
            tree-sitter-python = prev.tree-sitter-grammars.tree-sitter-python.overrideAttrs (_: {
              nativeBuildInputs = [
                final.nodejs
                final.tree-sitter
              ];
              configurePhase = ''
                tree-sitter generate --abi 13 src/grammar.json
              '';
            });
          };
        })
      ];
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ system ];
      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.alejandra;
        };
      flake = {
        nixosConfigurations = {
          server = lib.nixosSystem {
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

            modules = [
              ./hosts/desktop/configuration.nix

              home-manager.nixosModules.home-manager
              {
                nixpkgs.overlays = overlays;
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.josh = import ./home-manager/users/josh.nix;
                  backupFileExtension = "backup";
                  extraSpecialArgs = {
                    inherit inputs;
                  };
                };
              }
            ];
          };
          laptop = lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/laptop/configuration.nix

              home-manager.nixosModules.home-manager
              {
                nixpkgs.overlays = overlays;
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.josh = import ./home-manager/users/josh.nix;
                  backupFileExtension = "backup";
                  extraSpecialArgs = {
                    inherit inputs;
                  };
                };
              }
            ];
          };
          thonkpad = lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/thonkpad/configuration.nix

              home-manager.nixosModules.home-manager
              {
                nixpkgs.overlays = overlays;
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.josh = import ./home-manager/users/josh.nix;
                  backupFileExtension = "backup";
                  extraSpecialArgs = {
                    inherit inputs;
                  };
                };
              }
            ];
          };
        };
      };
    };
}
