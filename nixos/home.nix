{ config, pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" "kvm" "adbusers" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  programs.adb.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
