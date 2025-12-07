# About
My NixOS personal setup.

# Requirements
- You will need to install `git` on your current NixOS system to clone the repository.
    > Otherwise, you can use this command `nix-shell -p git` and copy the repo from here.
- *Optionally* you might install it using flakes, so you will need to have them enabled.
    > https://wiki.nixos.org/wiki/Flakes#:~:text=permanently-,NixOS,flakes%22%20%5D%3B

# To install
Run this commands inside of your home directory
```
git clone https://github.com/SeniorMatt/Matthew-s-NixOS.git 
```
```
# Replace `matthew` with the username you chose at the NixOS installation.
sudo chown -R matthew:users ~/Matthew-s-NixOS/nixos/ 
```
```
cp -f /etc/nixos/hardware-configuration.nix ~/Matthew-s-NixOS/nixos/hosts/t480/
```

## Without flakes
You can either symlink the configuration to `/etc/nixos`.
```
sudo mv /etc/nixos /etc/nixos-back
```
```
sudo ln -s ~/Matthew-s-NixOS/nixos /etc/nixos
``` 
so it will work by writing `sudo nixos-rebuild switch`. 

## With flakes
Or you can rebuild using this command
```
sudo nixos-rebuild switch --experimental-features 'nix-command flakes' --flake ~/Matthew-s-NixOS/nixos/
```
And there is an alias for that, after you did your initial setup `nrs`.

# Usage
You can switch between different setups by configuring `~/Matthew-s-NixOS/nixos/flake.nix` and changing the `session.desktop` variable.

# Screenshots
## KDE Plasma using Plasma Manager
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ff2d11b9-f9d6-4ed4-ae35-17b874d223fe" />

## Niri
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/dc559f1c-3802-40f8-a336-577160638010" />

## Hyprland rice
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2cef4d07-46ff-460c-82f5-4aaaacd9af83" />

## Hyprland minimal
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/da1c82bd-2971-46c8-8da1-b7661159ed0c" />

### My previous Hyprland rice with blur and stuff :D
![image_2025-07-09_22-39-49](https://github.com/user-attachments/assets/e1d60ae7-87b9-45bd-adec-3ad1cacef0fc)
![image](https://github.com/user-attachments/assets/5fed0521-ef1a-4589-9256-612d029f6c6c)
![image](https://github.com/user-attachments/assets/2815af78-f455-46b9-b14b-e7420467c810)
![image_2025-07-09_22-39-31](https://github.com/user-attachments/assets/4f265fc6-f89a-463b-a133-57f0f031ae74)
![image_2025-07-09_22-39-30](https://github.com/user-attachments/assets/3bfebee6-3370-4c8d-bf23-1ce84bfdea7e)
![image_2025-07-09_22-39-30 (2)](https://github.com/user-attachments/assets/d86757e6-20e4-4889-8289-1f572814da25)
