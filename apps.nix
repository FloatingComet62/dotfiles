{ config, pkgs, ... }:
{
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vscode
    discord
    localsend
    bitwarden
    obsidian
    jetbrains.pycharm-professional
    jetbrains.clion
    wineWowPackages.stable
  ];

  # for Localsend
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
}
