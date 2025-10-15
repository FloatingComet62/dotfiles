{ config, pkgs, ... }:
{
  imports =
    [
      ./beam.nix
      ./c.nix
      ./go.nix
      ./javascript.nix
      ./lua.nix
      ./python.nix
      ./rust.nix
      ./zig.nix
    ];
}
