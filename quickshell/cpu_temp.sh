temp=$(sensors | awk '/^Package id 0:/ {print int($4) + 273}')
echo "$temp"
