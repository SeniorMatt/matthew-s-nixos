# About
My NixOS personal setup.

# Requirements
- You will need to install `git` on your current NixOS system to clone the repository.
    > Otherwise, you can use this command `nix-shell -p git` and copy the repo from here.
- *Optionally, but it is the recommended way* you might install system using flakes, so you will need to have them enabled.
    > Follow this https://wiki.nixos.org/wiki/Flakes#:~:text=permanently-,NixOS,flakes%22%20%5D%3B

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
So it will work by writing `sudo nixos-rebuild switch`. 

## With flakes
Or you can rebuild using this command.
```
sudo nixos-rebuild switch --flake ~/Matthew-s-NixOS/nixos/
```
And there is an alias for that, after you did your initial setup `nrs`.

# Usage
You can switch between different setups by configuring `~/Matthew-s-NixOS/nixos/flake.nix` and changing the `session.desktop` variable.

# Screenshots
## KDE Plasma using Plasma Manager
<img width="1920" height="1080" alt="plasma-1" src="https://github.com/user-attachments/assets/4fa495a4-8704-487d-9940-d5291b952003" />
<img width="1920" height="1080" alt="plasma-2" src="https://github.com/user-attachments/assets/d592dd58-f9d0-4339-921c-5a1d86527cb2" />

## Niri
<img width="1920" height="1080" alt="niri-1" src="https://github.com/user-attachments/assets/a913aa26-42e4-478a-9886-c5fbf50d23d1" />
<img width="1920" height="1080" alt="niri-2" src="https://github.com/user-attachments/assets/f2e18852-769b-4fc1-9fa3-418b32fec8c8" />

## Cosmic 
<img width="1920" height="1080" alt="cosmic-1" src="https://github.com/user-attachments/assets/9b943310-c273-4927-910c-34c96a3fa6f5" />
<img width="1920" height="1080" alt="cosmic-2" src="https://github.com/user-attachments/assets/da26debc-5f51-48de-a8e3-5042e517f8b8" />

## Hyprland minimal
<img width="1920" height="1080" alt="hyprland-1" src="https://github.com/user-attachments/assets/e323cdfd-ceb9-4236-bbe4-804a704df0f7" />
<img width="1920" height="1080" alt="hyprland-2" src="https://github.com/user-attachments/assets/86516bb3-58c2-41b6-912b-4e9389fc6dfe" />

## Hyprland rice
<img width="1920" height="1080" alt="hyprland-rice-1" src="https://github.com/user-attachments/assets/f50cd9cb-8656-498f-afa6-9946c4e97292" />
<img width="1920" height="1080" alt="hyprland-rice-2" src="https://github.com/user-attachments/assets/b60024bb-eac7-4a7e-a0fc-3f4a62c4e205" />
