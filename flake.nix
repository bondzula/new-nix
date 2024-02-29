{
  description = "Stefan's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @inputs: {
    homeConfigurations = {
      "stefanbondzulic@hydrogen" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/hydrogen.nix
        ];
      };

      "bondzula@bondzula" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/bondzula.nix
        ];
      };

      # Servers
      "bondzula@helsinki" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/helsinki.nix
        ];
      };
    };
  };
}
