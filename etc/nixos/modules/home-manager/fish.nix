{
  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish | source
      zoxide init fish | source
      set -g fish_greeting
      alias nrp="sudo nixos-rebuild switch --flake /etc/nixos/#plasma"
      alias nrh="sudo nixos-rebuild switch --flake /etc/nixos/#hyprland"
      alias nfu="sudo nix flake update --flake /etc/nixos/flake.nix"
      alias n="nvim"
      alias ng="nvim ~/Documents/GitHub/"
      alias nx="sudo nvim /etc/nixos/"
      alias p="ping google.com"
      alias c="ffmpeg -i video.mp4 -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p output.mov"
      alias cr='ffmpeg -i video.mov -vf "scale=1920:-2:force_original_aspect_ratio=decrease:flags=lanczos,fps=60" -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -profile:v high -level 4.1 -movflags +faststart -c:a aac -b:a 160k output-reddit.mp4'
      alias bitit="steam-run ~/Documents/builds/latest-build/Bit\ It.x86_64"
      alias godot="steam-run ~/Documents/Godot_v4.5-stable_mono_linux_x86_64/Godot_v4.5-stable_mono_linux.x86_64"
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "montys";
    # montys - my beloved one
    # multiverse-neon
  };
}
