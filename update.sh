echo "------------- Updating dotfiles --------------"

cp ~/.config/starship.toml ~/Documents/dotfiles/
echo "Copied starship.toml"

cp ~/.zshrc ~/Documents/dotfiles/
echo "Copied .zshrc"

rm -r .themes/
cp -r ~/.themes/ ~/Documents/dotfiles/
echo "Copied .themes"

rm -r yazi/
cp -r ~/.config/yazi/ ~/Documents/dotfiles/
echo "Copied yazi"

rm -r nvim/
cp -r ~/.config/nvim/ ~/Documents/dotfiles/
echo "Copied nvim"

rm -r kitty/
cp -r ~/.config/kitty/ ~/Documents/dotfiles/
echo "Copied kitty"

rm -r neofetch/
cp -r ~/.config/neofetch/ ~/Documents/dotfiles/
echo "Copied neofetch"


pushd /etc/nixos
  cp configuration.nix ~/Documents/dotfiles/
popd
echo "Copied configuration.nix"

echo "------------- Copied all files --------------"

echo "------------- Pushing to git --------------"
git add .
git commit -m "Update"
git push origin master
echo "------------- Pushed to git --------------"
