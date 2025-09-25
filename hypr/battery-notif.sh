#!/usr/bin/env bash

while true; do
  status=$(cat /sys/class/power_supply/BAT1/status)
  if [[ "$status" = "Discharging" ]]; then
    battery=$(cat /sys/class/power_supply/BAT1/capacity)
    if [[ battery -lt 16 ]]; then
      notify-send -u critical "Very Low Battery" -i ~/.config/waybar/battery_critical.png
    elif [[ battery -lt 31 ]]; then
      notify-send -u normal "Low Battery" -i ~/.config/waybar/battery_low.png
    fi
  fi
  pid=$!
  sleep 5
  kill $pid
done
