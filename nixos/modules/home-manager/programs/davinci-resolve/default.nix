{ pkgs, inputs, ... }:
let
  older-pkgs = import inputs.nixpkgs-c5ae371f1 {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
     older-pkgs.davinci-resolve
     # davinci-resolve
  ];
}
