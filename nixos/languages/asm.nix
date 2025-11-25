{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fasm
  ];
}
