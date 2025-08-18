{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    python311
    zoxide
    starship
    cmake
    git-lfs
    inetutils
    btop
  ];
}
