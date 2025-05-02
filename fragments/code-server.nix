{ config, lib, pkgs, ... }:

{
  services.code-server = {
    enable = true;
    auth = "none"; # none or password
    port = 4444;
    user = "jekotia";
  };
}
