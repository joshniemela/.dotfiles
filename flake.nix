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
    	  ./hosts/image.nix
      	];
      };
     desktop = lib.nixosSystem {
       inherit system;
       modules = [
        ./hosts/desktop/configuration.nix
        home-manager.nixosModules.home-manager 
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.josh = import ./users/josh/home.nix;
          };
        }
       ]; 
     };
    };
  };
}
