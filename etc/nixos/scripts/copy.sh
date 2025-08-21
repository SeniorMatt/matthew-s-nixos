#!/bin/bash

echo "Copying NixOS configuration..."
sudo cp -r /etc/nixos/ ~/Documents/GitHub/Matthew-s-NixOS/etc/
sudo rm -f ~/Documents/GitHub/Matthew-s-NixOS/etc/nixos/hardware-configuration.nix

echo "Copying Dotfiles..."
sudo cp -r ~/.config/dunst/ ~/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r ~/.config/hypr/ ~/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r ~/.config/kitty/ ~/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r ~/.config/tofi/ ~/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r ~/.config/waybar/ ~/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r ~/.config/waybar/ ~/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r ~/.mozilla/firefox/r71gz7z2.default/chrome/ ~/Documents/GitHub/Matthew-s-NixOS/.mozilla/firefox/r71gz7z2.default/

echo "Copying Wallpapers..."
sudo cp -r ~/Pictures/my-catppuccin-wallpapers/ ~/Documents/GitHub/Matthew-s-NixOS/Pictures/
sudo cp ~/Pictures/avatar.png ~/Documents/GitHub/Matthew-s-NixOS/Pictures/
