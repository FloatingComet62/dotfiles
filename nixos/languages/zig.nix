{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    zig
    zls
  ];
}
