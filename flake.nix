{
  description = "System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "aargh";
      hostname = "pegasus";
      nvidia = true;

      # This is where I have keep the dotfiles folder, replace it accordingly
      symlinkRoot = "/home/${username}/dotfiles";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.main = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs username hostname unstable symlinkRoot nvidia;
        };

        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit username unstable symlinkRoot;
            };
            home-manager.backupFileExtension = "hm-backup";
            home-manager.users.${username} = import ./home-manager/home.nix;
          }
        ];
      };
    };
}
