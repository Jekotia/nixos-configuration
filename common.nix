# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jekotia = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRvdduzwOuCMFHXEDOyH1gB/WiQXO/mf/D+tWllIXhEqUPap73jmVU/Rx3MMLPaitHpTQ1ULl8UnwxsI4ZnZeRMlvomGtUHXL2wMFViEXSV3TJOt9KJu6hj5HR9/uI/c8z3iu6pA06oGyXHJ8qv+woF1f2icojmUk0tIH3Fqa3SMNdmW1u+kw1dk0UcxtV8XgLb+hRVZqVPbopttwn6Er7CT45ad00dog7YAIlm3gCFOlyIBJzTvCOcgInU7jpnnmXJyIkEIzjmphS0GRwr4sHNZSN8kOOy+H3y9XhM7fO4WNHRhIUPY7TScFormAJW4fZKzopiGp/1jiSB1yN6jC1 jameli@jupiter" ];
    packages = with pkgs; [
      tree
    ];
  };
  security.sudo.wheelNeedsPassword = false;


  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano
    nfs-utils
    wget
    spice-vdagent
    ncdu
    htop
    tmux
  ];

  #virtualisation.qemu.guestAgent.enable = true;
  services.qemuGuest.enable = true;

#source = builtins.fetchGit {
#  url = "https://github.com/hlissner/doom-emacs";
#  rev = "07fca786154551f90f36535bfb21f8ca4abd5027";
#};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings ={ 
      AllowUsers = [ "jekotia" ];
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      X11Forwarding = false;
    };
    extraConfig = ''
    # Protocol version
    Protocol 2

    # Log sftp level file access (read/write/etc.) that would not be easily logged otherwise.
    Subsystem sftp  /usr/lib/ssh/sftp-server -f AUTHPRIV -l INFO

	  # Disable  non-keypair authentication
    PermitEmptyPasswords no
    PubkeyAuthentication yes
    AuthenticationMethods publickey
    ChallengeResponseAuthentication no
    KerberosAuthentication no
    GSSAPIAuthentication no

    # Restrict allowed users

    # Prevent connections lingering open
    ClientAliveInterval 300
    ClientAliveCountMax 2

    # Limit number of auth attempts for a user
    MaxAuthTries 3

    # Limit amount of time to complete login once connected
    LoginGraceTime 20

    # Disable other unnecessary things that *could* pose a security risk
    AllowAgentForwarding no
    AllowTcpForwarding no
    PermitTunnel no
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

