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
    beamMinimal27Packages.elixir
    beamMinimal27Packages.erlang
    # (with beamMinimal27Packages; [
    #   elixir
    #   erlang
    # ])
  ];
}
