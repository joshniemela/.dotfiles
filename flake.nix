{
  description = "Josh's NixOS flake";
  inputs = {
    nixpkgs-small.url = "github:NixOs/nixpkgs/nixos-unstable-small";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    nix-ld.url = "github:Mic92/nix-ld";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    webcord.url = "github:fufexan/webcord-flake"; # foss discord
  };
  outputs = { self, nixpkgs, nixpkgs-small, nixpkgs-stable, nix-ld, home-manager, webcord, ... }@inputs:
  let 
    system = "x86_64-linux";
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config = { 
        allowUnfree = true; 
      };
    };
    pkgs = import nixpkgs {
      inherit system;
      config = { 
        allowUnfree = true; 
      };
    };
    
    lib = nixpkgs.lib;
    lib-small = nixpkgs-small.lib;
  in{
    nixosConfigurations = {
      server = lib-small.nixosSystem{
        inherit system;
        modules = [
	        ./hosts/server/configuration.nix
          home-manager.nixosModules.home-manager{
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.josh = import ./hosts/server/josh.nix;
            };
          }
        ];
      };

      liveISO = lib.nixosSystem {
        inherit system;
        
	      modules = [
    	  ./hosts/image.nix
      	];
      };

      desktop = lib.nixosSystem {
       inherit system;
       specialArgs = inputs;
       modules = [
        ./hosts/desktop/configuration.nix
        nix-ld.nixosModules.nix-ld

        home-manager.nixosModules.home-manager{
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.josh = import ./hosts/desktop/josh.nix;
            extraSpecialArgs = inputs;
          };
        }   
      ]; 
     };
     laptop = lib.nixosSystem {
       inherit system;
       specialArgs = inputs;
       modules = [
        ./hosts/laptop/configuration.nix
        nix-ld.nixosModules.nix-ld

        home-manager.nixosModules.home-manager{
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
  };
}
