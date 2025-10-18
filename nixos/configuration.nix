{ config, pkgs, username, hostname, ... }:
{
  imports =
    [
      ../hardware-configuration.nix
      ./cachix.nix
      ./boot.nix
      ./services.nix
      ./home.nix
      ./desktop-environment.nix
      ./environment.nix
      ./nvim.nix
      ./nvidia.nix
      ./languages
      ./apps.nix
      ./tmux.nix
    ];

  nix.settings = {
    cores = 6;
    max-jobs = 2;
    experimental-features = "nix-command flakes";
    trusted-users = [ "root" username ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
