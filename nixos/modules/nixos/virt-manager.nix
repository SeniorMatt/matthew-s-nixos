{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["matthew"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
