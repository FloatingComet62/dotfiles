connections=$(nmcli connection show --active | sed -n '2 p')
echo "$connections"
