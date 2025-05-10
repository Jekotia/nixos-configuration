{ config, lib, pkgs, ... }:

{
# TEMP
  # Disable firewall during testing phase
  networking.firewall.enable = false;
# END TEMP

  networking.domain = "jekotia.net";
  #-> Set time zone.
  time.timeZone = "America/Toronto";

  #-> Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jekotia = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };
  #-> Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  #-> My preferred shell
  programs.zsh.enable = true;


  programs.ssh.startAgent = true;


  nixpkgs.config.allowUnfree = true;
  #-> List packages installed in system profile. To search, run:
  #-> $ nix search wget
  environment.systemPackages = with pkgs; [
    #bc
    curl
    diffutils
    git
    gnugrep
    gzip
    htop
    iotop
    jq
    mc
    nano
    ncdu
    ookla-speedtest
    screen
    shellcheck
    sysstat
    tmux
    unzip
    wget
  ];

#source = builtins.fetchGit {
#  url = "https://github.com/hlissner/doom-emacs";
#  rev = "07fca786154551f90f36535bfb21f8ca4abd5027";
#};
}

