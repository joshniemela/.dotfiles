{
  description = "Josh's NixOS flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager,  ... }:

  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { 
        allowUnfree = true; 
      };
    };
    
    lib = nixpkgs.lib;

  in{
    homeManagerConfigurations = {
      josh = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "josh";
        homeDirectory = "/home/josh";
        stateVersion = "22.05";
        configuration = {
          imports = [
            ./users/josh/home.nix
          ];
        };
      };
    };
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
    	  ./hosts/iso/image.nix
      	];
      };
     desktop = lib.nixosSystem {
       inherit system;
       modules = [./hosts/desktop/configuration.nix]; 
     };
    };
  };
}
