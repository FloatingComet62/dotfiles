{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];

  # you do need to enable all of the ports because minecraft LAN uses a fucking
  # random one
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1024; to = 65535; }
    ];
    allowedUDPPortRanges = [
      { from = 1024; to = 65535; }
    ];
  };
}
