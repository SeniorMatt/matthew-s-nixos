{pkgs, ...}: {
  # Fun stuff :D
  home.packages = with pkgs; [
    neofetch # Fetcher
    pipes # Pipes
    cmatrix # Matrix effect
    cbonsai # Bonsai tree
    sl # Fucking train
    cowsay # What does the cow say?
    fortune # Fortune cookie
    asciiquarium # Ascii quarium
    cava # Audio visualizer
    tty-clock # TTY clock
  ];
}
