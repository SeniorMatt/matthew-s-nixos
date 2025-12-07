{ user, ... }:
let
  avatar = ../../../../../pictures/avatar-circle.png;
in
{
  config.system.activationScripts.createIcon = "ln -sfn ${avatar} /var/lib/AccountsService/icons/${user}.png";
}
