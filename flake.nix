{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        /etc/nixos/hosts/shared/configuration.nix
        /etc/nixos/hosts/desktop/host.nix
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        /etc/nixos/hosts/shared/configuration.nix
        /etc/nixos/hosts/laptop/host.nix
      ];
    };

    nixosConfigurations.crappylaptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.home-manager.nixosModules.default
        /etc/nixos/hosts/shared/configuration.nix
        /etc/nixos/hosts/crappylaptop/host.nix
      ];
    };
  };
}
