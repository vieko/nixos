{ config, lib, pkgs, ... }:

{
  imports = [ 
    <home-manager/nixos>
    ./hardware.nix
    ./windows.nix
    ./gnome.nix
  ];

  # +> SUID WRAPPERS
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # +> NETWORKING
  networking = {
    hostName = "pandemonium";
    networkmanager.enable = true;
    #wireless.networks = ./private-config/wifi.nix;
    firewall.enable = false;
    useDHCP = false;
    interfaces = {
      br0.useDHCP = true;
      eno2.useDHCP = true;
      wlo1.useDHCP = true;
    };
    bridges.br0 = {
      interfaces = [ "eno2" ];
    };
  };

  # +> LOCALIZATION
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Edmonton";

  # +> PACKAGES
  environment.systemPackages = with pkgs; [
    wget
    unzip
  ];

  # +> HOME MANAGER
  home-manager.users.vieko = (import ./home.nix {
    inherit config pkgs;
  });

  # +> SERVICES
  services.openssh.enable = true;

  # +> USERS
  users.users.vieko = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" ];
    shell = pkgs.fish;
    uid = 1000;
    openssh.authorizedKeys.keys = [
      (builtins.readFile ~/.ssh/id_rsa.pub)
    ];
  };

  # +> CONFIG
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
    trustedUsers = [ "root" "vieko" ];
    # extraOptions = ''
    #   keep-outputs = true
    #   keep-derivations = true
    # '';
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09";

}

