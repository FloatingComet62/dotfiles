if [[ "$1" == "load_in" ]]
then
  echo "load_in"
  sudo cp /etc/nixos/* ~/dotfiles/nixos/ -r
  sudo cp ~/.config/nvim/* ~/dotfiles/nvim/ -r
  sudo cp ~/.zshrc ~/dotfiles/
  sudo cp ~/.gitconfig ~/dotfiles/
fi
if [[ "$1" == "load_out" ]] then
  echo "load_out"
  sudo cp  ~/dotfiles/nixos/* /etc/nixos/ -r
  sudo cp  ~/dotfiles/nvim/* ~/.config/nvim/ -r
  sudo cp ~/dotfiles/.gitconfig ~/
fi
if [[ "$1" == "git" ]] then
  echo "update"
  message="$(date +%Y/%m/%d-%H:%M:%S)"
  git add .
  git commit -m "update $message"
  git push origin master
fi
