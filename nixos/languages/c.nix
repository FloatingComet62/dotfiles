{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    gcc
    cmake
    clang-tools
  ];
}
