{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    cargo
    rust-analyzer
  ];
}
