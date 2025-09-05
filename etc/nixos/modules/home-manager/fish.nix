{
  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish | source
      zoxide init fish | source
      set -g fish_greeting
      alias nrs="sudo nixos-rebuild switch"
      alias nfu="sudo nix flake update"
      alias n="nvim"
      alias ng="nvim ~/Documents/GitHub/"
      alias nx="sudo nvim /etc/nixos/"
      alias p="ping google.com"
      alias convert="ffmpeg -i video.mp4 -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p output.mov"
      alias bitit="steam-run ~/Documents/GitHub/builds/latest-build/Bit\ It.x86_64"
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "montys";
  };
}
