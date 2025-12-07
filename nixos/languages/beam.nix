{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    beamMinimal27Packages.elixir
    beamMinimal27Packages.elixir-ls
  ];
}
