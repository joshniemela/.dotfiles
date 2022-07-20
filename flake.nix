{
  description = "Server and usb config flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
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
	      ./system/configuration.nix
	      ];
      };

      liveISO = lib.nixosSystem {
        inherit system;
        
	      modules = [
    	  ./system/image.nix
      	];
      };
    };
  };
}
