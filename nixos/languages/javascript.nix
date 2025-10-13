{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    nodejs_20
    typescript-language-server
    javascript-typescript-langserver
  ];
}
