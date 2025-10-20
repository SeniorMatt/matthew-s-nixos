{
  programs.git = {
    enable = true;
    userName = "SeniorMatt";
    userEmail = "matthew.prakhov@gmail.com";
    extraConfig = {
      credential.helper = "store";
    };
    # pull rebase false
  };
}
