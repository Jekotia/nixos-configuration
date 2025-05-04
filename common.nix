{ config, lib, pkgs, ... }:

{
# TEMP
  # Disable firewall during testing phase
  networking.firewall.enable = false;
# END TEMP

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jekotia = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };
  security.sudo.wheelNeedsPassword = false;
  programs.zsh.enable = true;
  programs.ssh.startAgent = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    jq
    nano
    ncdu
    screen
    shellcheck
    tmux
    wget
  ];

#source = builtins.fetchGit {
#  url = "https://github.com/hlissner/doom-emacs";
#  rev = "07fca786154551f90f36535bfb21f8ca4abd5027";
#};
}

