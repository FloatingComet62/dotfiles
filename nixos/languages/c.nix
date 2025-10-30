{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    cmake
    clang-tools
  ];
}
