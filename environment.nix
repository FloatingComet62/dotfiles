{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    python311
    zoxide
    starship
    tmux
    cmake
    git-lfs
    inetutils
    btop
  ];
}
