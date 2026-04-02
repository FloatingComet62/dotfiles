{ config, pkgs, ... }:
{
  imports =
    (if games.minecraft then [ ./minecraft.nix ] else []);
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    steam-run
  ];
}
