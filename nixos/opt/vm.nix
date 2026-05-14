{ config, pkgs, username, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.${username}.extraGroups = [
    "libvirtd"
  ];

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
    mkcert
  ];

  networking.extraHosts = ''
    192.168.122.232 home.arpa
  '';
}
