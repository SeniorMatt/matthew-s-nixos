#!/bin/bash

echo "Copying NixOS configuration..."
sudo cp -r /etc/nixos/ ~/Documents/GitHub/Matthew-s-NixOS/etc/
sudo rm -f ~/Documents/GitHub/Matthew-s-NixOS/etc/nixos/hardware-configuration.nix

echo "Copying Wallpapers..."
sudo cp -r ~/Pictures/wallpapers/ ~/Documents/GitHub/Matthew-s-NixOS/Pictures/
sudo cp -r ~/Pictures/wallpapers/catppuccin/ ~/Documents/GitHub/Matthew-s-NixOS/Pictures/wallpapers/
sudo cp ~/Pictures/avatar.png ~/Documents/GitHub/Matthew-s-NixOS/Pictures/
