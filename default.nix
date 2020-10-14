{ config, pkgs, ... }:

{
  imports = [ 
    <home-manager/nixos>

    ./hardware.nix
    ./config.nix
    ./calgary.nix
    ./windows.nix

    ./gnome.nix
    #./fonts.nix

    ./chromium.nix
  ];

  # +> HOME MANAGER
  home-manager.users.vieko = (import ./home.nix {
    inherit pkgs config;
  });

  # +> BOOT
  boot = {
    cleanTmpDir = true;
    loader = {
      systemd-boot.enable      = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = false;
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

  # +> SERVICES
  services.openssh.enable = true;
  
  # +> PACKAGES
  environment.systemPackages = with pkgs; [

    # Apps
    firefox-devedition-bin
    slack
    discord

  ];


  # +> USERS
  users.users.vieko = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" ];
    #shell = pkgs.zsh;
    #openssh.authorizationKeys.keys = [
    #  (builtins.readFile ../private-config/ssh/id_rsa.pub)
    #];
  };

  system.stateVersion = "20.09";

}

