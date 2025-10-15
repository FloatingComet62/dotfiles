{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    beamMinimal27Packages.elixir
    beamMinimal27Packages.erlang
    beamMinimal27Packages.elixir-ls
    beamMinimal27Packages.erlang-ls
  ];
}
