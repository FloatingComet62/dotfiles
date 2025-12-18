battery=$(cat /sys/class/power_supply/BAT1/capacity)
charging=$(cat /sys/class/power_supply/ACAD/online)
echo "$battery $charging"
