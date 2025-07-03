{ config, pkgs, ... }:
{
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vscode
    discord
    localsend
    bitwarden
    jetbrains.pycharm-professional
    jetbrains.clion
  ];

  # for Localsend
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
}
