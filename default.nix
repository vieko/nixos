{ config, lib, pkgs, ... }:

{
  imports = [ 
    <home-manager/nixos>
    ./hardware.nix
    ./chaos.nix
    ./windows.nix
    ./docker.nix
    ./gnome.nix
    # ./plex.nix
    # ./xmonad.nix
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
    nameservers = [ "1.1.1.1"  "1.0.0.1" ];
    enableIPv6 = false;
  };

  # +> SHARES
  # services.samba = {
  #   enable = true;
  #   extraConfig = ''
  #     browseable = yes
  #     smb encrypt = required
  #   '';

  #   shares = {
  #     homes = {
  #       browseable = "no";
  #       "read only" = "no";
  #       "guest ok" = "no";
  #     };
  #   };
  # };

  #services.samba = {
  #  enable = true;
  #  securityType = "user";
  #  extraConfig = ''
  #      #workgroup = WORKGROUP
  #      #server string = smbnix
  #      #netbios name = smbnix
  #      security = user 
  #      #use sendfile = yes
  #      #max protocol = smb2
  #      hosts allow = 192.168.0  localhost
  #      hosts deny = 0.0.0.0/0
  #      guest account = nobody
  #      map to guest = bad user
  #    '';
  #  shares = {
  #      public = {
  #        path = "/mnt/Shares/Public";
  #        browseable = "yes";
  #        "read only" = "no";
  #        "guest ok" = "yes";
  #        "create mask" = "0644";
  #        "directory mask" = "0755";
  #        # "force user" = "vieko";
  #        # "force group" = "users";
  #      };
  #      private = {
  #        path = "/mnt/Shares/Private";
  #        browseable = "yes";
  #        "read only" = "no";
  #        "guest ok" = "no";
  #        "create mask" = "0644";
  #        "directory mask" = "0755";
  #        "force user" = "vieko";
  #        "force group" = "users";
  #      };
  #    };
  #};

  # +> LOCALIZATION
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Edmonton";

  # +> PACKAGES
  environment.systemPackages = with pkgs; [
    wget
    unzip
    awscli2
    # insomnia
    parsecgaming
    # popshell
    # looking-glass-client
    # lm_sensors
    # unite-shell
    # popshell-shortcuts
    python38
    python38Packages.pip
    python38Packages.setuptools
    python38Packages.wheel
    python38Packages.cfn-lint
  ];

  nixpkgs.overlays = [
    (
      self: super: {
        # https://github.com/NixOS/nixpkgs/issues/127982
        awscli2 = (
          import (
            builtins.fetchTarball {
              url =
                "https://github.com/NixOS/nixpkgs/archive/a81163d83b6ede70aa2d5edd8ba60062ed4eec74.tar.gz";
              sha256 = "0xwi0m97xgl0x38kf9qq8m3ismcd7zajsmb82brfcxw0i2bm3jyl";
            }
          ) { config = { allowUnfree = true; }; }
        ).awscli2;
      }
    )
  ];


  nixpkgs.config.packageOverrides = pkgs: rec {
    # insomnia = pkgs.callPackage ./custom/insomnia.nix {};
    parsecgaming = pkgs.callPackage ./custom/parsecgaming.nix {};
    # popshell = pkgs.callPackage ./custom/popshell.nix {};
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
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" "audio"
    "plex" "docker" ];
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
    # package = pkgs.nixFlakes;
    # registry.nixpkgs.flake = "nixpkgs/nixos-unstable";
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "21.11";

}

