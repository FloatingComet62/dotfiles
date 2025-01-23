if [[ "$1" == "load_in" ]]
then
  echo "load_in"
  sudo cp /etc/nixos/* ~/dotfiles/nixos/ -r
  sudo cp ~/.config/nvim/* ~/dotfiles/nvim/ -r
  sudo cp ~/.config/fish/* ~/dotfiles/fish/ -r
  sudo cp ~/.gitconfig ~/dotfiles/home
  sudo cp ~/shell.nix ~/dotfiles/home
  sudo cp ~/setup.nix ~/dotfiles/home
elif [[ "$1" == "load_out" ]]
then
  echo "load_out"
  sudo cp ~/dotfiles/nixos/* /etc/nixos/ -r
  sudo cp ~/dotfiles/nvim/* ~/.config/nvim/ -r
  sudo cp ~/dotfiles/fish/* ~/.config/fish/ -r
  sudo cp ~/dotfiles/home/* ~/
elif [[ "$1" == "git" ]]
then
  echo "git"
  message="$(date +%Y/%m/%d-%H:%M:%S)"
  git add .
  git commit -m "update $message"
  git push origin master
else
  echo "Possible Commands: load_in, load_out, git"
fi
