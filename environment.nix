{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    python311
    zoxide
    starship
    tmux
    cmake
  ];

  programs.mosh.enable = true;
}
