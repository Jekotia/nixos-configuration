{ config, lib, pkgs, ... }:

#-> Enable docker
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    #-> Disable undesirable features
    autoPrune.enable = false;
    rootless.enable = false;
  };
}
