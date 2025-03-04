# Nix Channels
# nix-ld https://github.com/Mic92/nix-ld/archive/main.tar.gz
# nixos https://channels.nixos.org/nixos-24.11
# nixos-unstable https://nixos.org/channels/nixos-unstable
# home-manager https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz

{ config, pkgs, ... }:{
  imports = [
      ./hardware-configuration.nix
      ./boot.nix
      ./services.nix
      ./packages.nix
      ./time.nix
      <home-manager/nixos>
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    allowedTCPPorts = [53317];
    allowedUDPPorts = [53317];
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.aargh = {
    isNormalUser = true;
    description = "aargh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kate
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  system.stateVersion = "24.11";
}
