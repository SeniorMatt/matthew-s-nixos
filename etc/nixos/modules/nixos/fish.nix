{ pkgs, user, ... }:
{
  users.users.${user}.shell = pkgs.fish;
  programs.fish = {
    enable = true;
    shellInit = ''
      zoxide init fish | source
      set -g fish_greeting
    '';
    shellAliases = {
      nrp = "sudo nixos-rebuild switch --flake /etc/nixos/#plasma";
      nrm = "sudo nixos-rebuild switch --flake /etc/nixos/#minimal";
      nrh = "sudo nixos-rebuild switch --flake /etc/nixos/#hyprland";
      nrn = "sudo nixos-rebuild switch --flake /etc/nixos/#niri";
      nx = "sudo nvim /etc/nixos/";
      ng = "sudo nvim ~/Documents/GitHub/";
      p = "ping google.com";
      c = "ffmpeg -i video.mp4 -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p output.mov";
      cr = "ffmpeg -i video.mov -vf 'scale=1920:-2:force_original_aspect_ratio=decrease:flags=lanczos,fps=60' -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -profile:v high -level 4.1 -movflags +faststart -c:a aac -b:a 160k output-reddit.mp4";
      bitit = "steam-run ~/Documents/builds/latest-build/'Bit It.x86_64'";
    };
  };
}
