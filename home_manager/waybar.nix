{...}: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [{
      layer = "top";
      position = "top";
      mod = "dock";
      exclusive = true;
      passtrough = false;
      gtk-layer-shell = true;
      height = 0;
      modules-left = [
        "hyprland/workspaces"
        "custom/divider"
        "custom/weather"
        "custom/divider"
        "cpu"
        "custom/divider"
        "memory"
      ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "tray"
        "network"
        "custom/divider"
        "backlight"
        "custom/divider"
        "pulseaudio"
        "custom/divider"
        "battery"
        "custom/divider"
        "clock"
      ];
      "hyprland/window" = { format = "{}"; };
      "wlr/workspaces" = {
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        all-outputs = true;
        on-click = "activate";
      };
      "custom/weather" = {
        tooltip = true;
        format = "{}";
        restart-interval = 300;
        exec = "/home/roastbeefer/.cargo/bin/weather";
      };
      tray = {
        icon-size = 13;
        tooltip = false;
        spacing = 10;
      };
      "custom/divider" = {
        format = " | ";
        interval = "once";
        tooltip = false;
      };
      "custom/endright" = {
        format = "_";
        interval = "once";
        tooltip = false;
      };
    }];
  };
}

