{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    cargo
    python311
    zoxide
    starship
    tmux
    cmake
  ];
}
