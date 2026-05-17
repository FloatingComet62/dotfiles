{ config, pkgs, opt, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
  ] ++ (if opt.nvidia then [
    (writeShellScriptBin "prismlauncher-nvidia" ''
      exec env \
        __NV_PRIME_RENDER_OFFLOAD=1 \
        __GLX_VENDOR_LIBRARY_NAME=nvidia \
        __VK_LAYER_NV_optimus=NVIDIA_only \
        ${pkgs.prismlauncher}/bin/prismlauncher "$@"
    '')
  ] else []);

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
