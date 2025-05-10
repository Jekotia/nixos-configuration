{ config, lib, pkgs, ... }:

{
  imports = [
      ./common.nix
      ../fragments/docker.nix
    ];

  # Set hostname.
  networking.hostName = "nixos";

  #-> fstab entries
  fileSystems = {
    "/multimedia" = {
      device = "//10.0.0.10/multimedia";
      fsType = "cifs";
      options = [
        "credentials=/home/jekotia/.smbcredentials/multimedia"
        "uid=1000"
        "gid=1000"
      ];
    };
    "/srv/ref" = {
      device = "10.0.0.10:/mnt/storage/servers/saturn/hyperion";
      fsType = "nfs";
      options = [ "defaults" ];
    };
  };
}
