{ config, pkgs, ... }:
{
  users.users.aargh = {
    isNormalUser = true;
    description = "Aargh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  home-manager.users.aargh = { pkgs, ... }: {
    programs.firefox.enable = true;
    home.stateVersion = "25.05";
  };
  home-manager.backupFileExtension = "hm-backup";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };


  environment.systemPackages = with pkgs; [
    fastfetch
    vim
    wget
    git
    nmap
    dust
    gnome-tweaks
    home-manager
  ];
}
