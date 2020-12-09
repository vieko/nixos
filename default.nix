{ config, lib, pkgs, ... }:

{
  imports = [ 
    <home-manager/nixos>
    ./hardware.nix
    ./chaos.nix
    ./windows.nix
    ./docker.nix
    ./gnome.nix
  ];

  # +> SUID WRAPPERS
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # +> STEAM
  programs.steam.enable = true;

  # +> NETWORKING
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    useDHCP = false;
    nameservers = [ "8.8.8.8"  "8.8.4.4" ];
    enableIPv6 = false;
  };

  # +> LOCALIZATION
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Edmonton";

  # +> PACKAGES
  environment.systemPackages = with pkgs; [
    wget
    unzip
    insomnia
    popshell
    # looking-glass-client
    # lm_sensors
    # unite-shell
    # popshell-shortcuts
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    insomnia = pkgs.callPackage ./custom/insomnia.nix {};
    popshell = pkgs.callPackage ./custom/popshell.nix {};
    # looking-glass-client = pkgs.callPackage ./custom/looking-glass-client.nix {};
    # lm_sensors = pkgs.callPackage ./custom/lm-sensors.nix {};
    # unite-shell = pkgs.callPackage ./custom/uniteshell.nix {};
    # popshell-shortcuts = pkgs.callPackage ./custom/popshell-shortcuts.nix {};
  };

  # +> HOME MANAGER
  home-manager.users.vieko = (import ./home.nix {
    inherit config pkgs;
    # nixpkgs.config = import ./config.nix;
  });

  # +> SERVICES
  services.openssh.enable = true;

  # +> USERS
  users.users.vieko = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" "audio" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      (builtins.readFile /home/vieko/.ssh/id_rsa.pub)
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

