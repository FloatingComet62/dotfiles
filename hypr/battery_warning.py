import psutil
import subprocess
import time

WARNING_LEVEL = 30
CRITICAL_LEVEL = 15

while True:
    battery = psutil.sensors_battery()
    percent = battery.percent
    if battery.power_plugged:
        pass  # Optionally notify full
    else:
        if percent <= CRITICAL_LEVEL:
            subprocess.run(['notify-send', '-u', 'critical', 'Very Low Battery', '-i', '/home/aargh/.config/waybar/battery_low.png'])
        elif percent <= WARNING_LEVEL:
            subprocess.run(['notify-send', '-u', 'normal', 'Low Battery', '-i', '/home/aargh/.config/waybar/battery_low.png'])
    time.sleep(5)
