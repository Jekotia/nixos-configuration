{ config, lib, pkgs, ... }:

{
  imports = [
      ./common.nix
      ../fragments/docker.nix
    ];

  networking.hostName = "hyperion"; # Define your hostname.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
#  environment.systemPackages = with pkgs; [
#  ];

  # fstab entries
  fileSystems = {
    "/multimedia" = {
      device = "//10.0.0.10/multimedia";
      type = "cifs";
      options = "credentials=/home/jekotia/.smbcredentials/multimedia,uid=1000,gid=1000";
    };
    "/srv/ref" = {
      device = "10.0.0.10:/mnt/storage/servers/saturn/hyperion";
      type = "nfs";
      options = "defaults";
  };
}
