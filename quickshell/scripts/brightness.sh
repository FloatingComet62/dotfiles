brightness=$(brightnessctl | grep 'Current brightness' | grep -o '[0-9]\+' | head -n 1)
temp=$(hyprctl hyprsunset temperature 2>/dev/null | grep -o '[0-9]\+')
if [ -z "$temp" ]; then temp=6000; fi
echo "$brightness $temp"
