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
}
