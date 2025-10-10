{ config, pkgs, ... }:
{
  users.users.aargh = {
    isNormalUser = true;
    description = "Aargh";
    extraGroups = [ "networkmanager" "wheel" "kvm" "adbusers" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  programs.adb.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  home-manager.users.aargh = { pkgs, ... }: {
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
