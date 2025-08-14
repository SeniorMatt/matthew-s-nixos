{
  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish | source
      zoxide init fish | source
      set -g fish_greeting
      alias nrs="sudo nixos-rebuild switch"
      alias nru="sudo nixos-rebuild switch --upgrade"
      alias n="nvim"
      alias ng="nvim ~/Documents/GitHub/"
      alias nx="sudo nvim /etc/nixos/"
      alias bitit="steam-run ~/Documents/GitHub/GodotTest/builds/latest-build/Bit\ It.x86_64"
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "montys";
  };
}
