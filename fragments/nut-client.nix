{ config, lib, pkgs, ... }:

{
  power.ups = {
    enable = true;
    mode = "netclient";
    upsmon = {
        enable = true;
        monitor.enceladus = {
            system = "10.0.0.10";
            user = "upsmon";
            powerValue = 1;
            passwordFile = "/etc/nut/password";
            type = "slave";
       };
    };
  };
}