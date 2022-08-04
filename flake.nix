{
  description = "Josh's NixOS flake";
  inputs = {
    nixpkgs-small.url = "nixpkgs/nixos-unstable-small";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, nixpkgs-small, home-manager, ... }:
  let 
    system = "x86_64-linux";

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
       modules = [
        ./hosts/desktop/configuration.nix

        home-manager.nixosModules.home-manager{
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.josh = import ./hosts/desktop/josh.nix;
          };
        }   
      ]; 
     };
     laptop = lib.nixosSystem {
       inherit system;
       modules = [
        ./hosts/laptop/configuration.nix

        home-manager.nixosModules.home-manager{
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.josh = import ./hosts/laptop/josh.nix;
          };
        }
      ]; 
     };
    };
  };
}
