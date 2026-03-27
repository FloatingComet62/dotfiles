{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zellij
  ];
}
