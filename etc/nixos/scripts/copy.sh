#!/bin/bash

echo "Copying NixOS configuration..."
sudo cp -r /etc/nixos/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/etc/
sudo rm -f /home/matthew/Documents/GitHub/Matthew-s-NixOS/etc/nixos/hardware-configuration.nix

echo "Copying Dotfiles..."
sudo cp -r /home/matthew/.config/dunst/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r /home/matthew/.config/hypr/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r /home/matthew/.config/kitty/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r /home/matthew/.config/nvim/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r /home/matthew/.config/tofi/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r /home/matthew/.config/waybar/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/
sudo cp -r /home/matthew/.config/wlogout/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/.config/

echo "Copying Wallpapers..."
sudo cp -r /home/matthew/Pictures/my-catppuccin-wallpapers/ /home/matthew/Documents/GitHub/Matthew-s-NixOS/Pictures/
sudo cp /home/matthew/Pictures/avatar.png /home/matthew/Documents/GitHub/Matthew-s-NixOS/Pictures/
