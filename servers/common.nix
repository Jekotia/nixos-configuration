{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
  ];


  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  users.users.jekotia.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRvdduzwOuCMFHXEDOyH1gB/WiQXO/mf/D+tWllIXhEqUPap73jmVU/Rx3MMLPaitHpTQ1ULl8UnwxsI4ZnZeRMlvomGtUHXL2wMFViEXSV3TJOt9KJu6hj5HR9/uI/c8z3iu6pA06oGyXHJ8qv+woF1f2icojmUk0tIH3Fqa3SMNdmW1u+kw1dk0UcxtV8XgLb+hRVZqVPbopttwn6Er7CT45ad00dog7YAIlm3gCFOlyIBJzTvCOcgInU7jpnnmXJyIkEIzjmphS0GRwr4sHNZSN8kOOy+H3y9XhM7fO4WNHRhIUPY7TScFormAJW4fZKzopiGp/1jiSB1yN6jC1 jameli@jupiter" ];

  services.qemuGuest.enable = true;

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
}

