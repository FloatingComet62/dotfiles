{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_24
    pnpm
    bun
    typescript-language-server
    javascript-typescript-langserver
  ];
}
