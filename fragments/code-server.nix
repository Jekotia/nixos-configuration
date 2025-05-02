{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    code-server
  ];
  services.code-server = {
    enable = true;
    auth = "none"; # none or password
    port = 4444;
    user = "jekotia";
    host = 0.0.0.0;
  };
}
