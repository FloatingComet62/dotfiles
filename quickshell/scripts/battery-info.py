# this script was used to generate the battery-info.sh via chatgpt

import subprocess

output = subprocess.run(
    ["upower", "--enumerate"],
    capture_output=True
).stdout.decode('utf-8')

target = None

for line in output.split("\n"):
    if "BAT" not in line:
        continue
    target = line
    break

print(line)

output = subprocess.run(
    ["upower", "-i", line],
    capture_output=True
).stdout.decode('utf-8')

energy = None
voltage = None
capacity = None

for line in output.split("\n"):
    if energy is None and "energy:" in line:
        energy = line.split(":")[1].strip()
    if voltage is None and "voltage:" in line:
        voltage = line.split(":")[1].strip()
    if capacity is None and "capacity:" in line:
        capacity = line.split(":")[1].strip()

print("energy:", energy)
print("voltage:", voltage)
print("capacity:", capacity)
