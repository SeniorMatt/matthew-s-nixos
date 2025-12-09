{ pkgs, inputs, ... }:
let
  pkgs-ee930f975 = import inputs.nixpkgs-ee930f975 {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
     pkgs-ee930f975.davinci-resolve
  ];
}
