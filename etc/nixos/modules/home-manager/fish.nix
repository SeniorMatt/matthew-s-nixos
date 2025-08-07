{
  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish | source
      zoxide init fish | source
      set -g fish_greeting
      alias nr="sudo nixos-rebuild switch"
      alias n="nvim"
      alias ng="nvim ~/Documents/GitHub/"
      alias nx="sudo nvim /etc/nixos/"
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableFishIntegration = true;
    useTheme = "montys";
  };
}
