{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    # bashrcExtra = ''
    #   eval "$(zoxide init bash)"
    #   ${pkgs.fortune}/bin/fortune | ${pkgs.cowsay}/bin/cowsay -f stegosaurus
    # '';
    shellAliases = {
      nx = "nvim /etc/nixos/";
      ng = "nvim ~/Documents/GitHub/";
      nu = "nvim --listen /tmp/nvimsocket";
      p = "ping google.com";
      c = "ffmpeg -i video.mp4 -c:v dnxhd -profile:v dnxhr_hq -c:a pcm_s16le -pix_fmt yuv422p output.mov";
      cr = "ffmpeg -i video.mov -vf 'scale=1920:-2:force_original_aspect_ratio=decrease:flags=lanczos,fps=60' -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -profile:v high -level 4.1 -movflags +faststart -c:a aac -b:a 160k output-reddit.mp4";
      bitit = "steam-run ~/Documents/builds/latest-build/'Bit It.x86_64'";
    };
  };
}
