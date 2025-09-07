#!/usr/bin/env bash

while true; do
  wall=$(find "$HOME/Pictures/Wallpapers" -type f | shuf -n 1)
  swaybg -i "$wall" -m fill &
  pid=$!
  sleep 600
  kill $pid
done
