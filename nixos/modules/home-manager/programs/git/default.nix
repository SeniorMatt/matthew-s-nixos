{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "SeniorMatt";
        email = "matthew.prakhov@gmail.com";
      };
      # pull rebase false
      credential.helper = "store";
    };
  };
}
