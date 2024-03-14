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
    in {
      nixosConfigurations = {
        "rome" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos/proxmox-lxc.nix ];
          specialArgs = { hostname = "rome"; };
        };

        "nairobi" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos/proxmox-lxc.nix ];
          specialArgs = { hostname = "nairobi"; };
        };

        "bern" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos/proxmox-lxc.nix ];
          specialArgs = { hostname = "bern"; };
        };

        "dublin" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos/proxmox-lxc.nix ];
          specialArgs = { hostname = "dublin"; };
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
        "bondzula@rome" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/rome.nix ];
        };

        "bondzula@nairobi" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/rome.nix ];
        };

        "bondzula@bern" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/bern.nix ];
        };

        "bondzula@helsinki" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/helsinki.nix ];
        };

        "bondzula@oslo" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home-manager/oslo.nix ];
        };
      };
    };
}
