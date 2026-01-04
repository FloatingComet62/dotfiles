{
  description = "System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: we're using "libgbm" and is only available in unstable so
        # ensure to have it up-to-date or simply don't specify the nixpkgs input
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    quickshell,
  ... }@inputs:
    let
      system = "x86_64-linux";
      username = "aargh";
      hostname = "pegasus";
      opt = {
        nvidia = true;
        llm = true;
      };
      languages = {
        c = true;
        asm = true;
        lua = true;
        python = true;

        go = false;
        beam = false;
        javascript = false;
        rust = false;
        zig = false;
      };

      # This is where I have keep the dotfiles folder, replace it accordingly
      symlinkRoot = "/home/${username}/dotfiles";

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.main = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit quickshell inputs system
            username hostname unstable symlinkRoot opt languages;
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
