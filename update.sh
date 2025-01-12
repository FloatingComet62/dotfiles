echo $1

if [[ $1 -eq "load_in" ]] then
  sudo cp /etc/nixos/* ~/dotfiles/nixos/ -r
  sudo cp ~/.config/nvim/* ~/dotfiles/nvim/ -r
fi
if [[ $1 -eq "load_out" ]] then
  sudo cp  ~/dotfiles/nixos/* /etc/nixos/ -r
  sudo cp  ~/dotfiles/nvim/* ~/.config/nvim/ -r
fi
if [[ $1 -eq "update" ]] then
  message = "update"
  message += date +%Y/%m/%d-%H:%M:%S
  git add .
  git commit -m message
  git push origin master
fi
