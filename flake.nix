{
  description = "Stefan's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-stable, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      pkgs-stable = nixpkgs-stable.legacyPackages.aarch64-darwin;

      nixosModules = builtins.listToAttrs (map (module: {
        name = module;
        value = import (./modules + "/${module}");
      }) (builtins.attrNames (builtins.readDir ./modules)));
    in {
      nixosConfigurations = {
        "berlin" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ ./nixos/berlin { imports = builtins.attrValues nixosModules; } ];
          specialArgs = { hostname = "berlin"; };
        };
      };

      homeConfigurations = {
        "stefanbondzulic@hydrogen" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/hydrogen.nix ];
          extraSpecialArgs = { inherit pkgs-stable; };
        };

        "bondzula@bondzula" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/bondzula.nix ];
        };

        # Servers
        "bondzula@berlin" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/berlin.nix ];
        };
      };
    };
}
