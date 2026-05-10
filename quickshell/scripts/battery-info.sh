#!/usr/bin/env bash

target=$(upower --enumerate | awk '/BAT/ { print; exit }')

upower -i "$target" | awk -F: '
/energy:/ && !e { e=$2 }
/voltage:/ && !v { v=$2 }
/capacity:/ && !c { c=$2 }
END {
  gsub(/^[ \t]+/, "", e)
  gsub(/^[ \t]+/, "", v)
  gsub(/^[ \t]+/, "", c)

  print "energy:", e
  print "voltage:", v
  print "capacity:", c
}'
