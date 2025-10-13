{ config, pkgs, ... }:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.mongodb = {
    enable = true;
    bind_ip = "127.0.0.1";
    package = pkgs.mongodb;
  };
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
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
