{ config, pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    settings.General.Enable = "Source,Sink,Media.Socket";
    settings.General.Experimental = true;
  };
  systemd.user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
  systemd.oomd.enable = true;
  zramSwap.enable = true;

  security.rtkit.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.blueman.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;
    services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.power-profiles-daemon.enable = true;
  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.kanata = {
    enable = true;
    keyboards = {
      "keyboard".config = ''
        (defsrc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret
          caps a    s    d    f    g    h    j    k    l    ;    '    \
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt  spc  ralt rmet rctl
        )
        (deflayer qwerty
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    ret
          esc  a    s    d    f    g    h    j    k    l    ;    '    \
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt  spc  ralt rmet rctl
        )
      '';
    };
  };
}
