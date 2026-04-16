{ config, pkgs, games, ... }:
{
  imports =
    (if games.minecraft then [ ./minecraft.nix ] else []);
  programs.steam.enable = true;
  programs.steam.protontricks.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
  environment.systemPackages = with pkgs; [
    steam-run
    mangohud
    freetype
    fontconfig
  ];
}
