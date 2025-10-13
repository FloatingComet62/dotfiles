{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    go
    gopls
  ];
}
