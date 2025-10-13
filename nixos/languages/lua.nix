{ config, pkgs, ... }:
in {
  environment.systemPackages = with pkgs; [
    lua
    lua-language-server
    lua53Packages.luarocks
    lua53Packages.luafilesystem
  ];
}
