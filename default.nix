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

  # +> NETWORKING (NextDNS)
  networking = {
    networkmanager = {
      enable = true;
      dns = "default";
    };
    nameservers = [];
    enableIPv6 = true;
  };

  # +> DYNAMIC DNS
  services.ddclient = {
    enable = true;
    configFile = "/home/vieko/Darkness/Secrets/ddclient.conf";
  };


  # +> NETWORKING (Encrypted)
  # networking = {
  #   networkmanager = {
  #     enable = true;
  #     dns = "none";
  #   };
  #   nameservers = [ "127.0.0.1" "::1" ];
  #   resolvconf.useLocalResolver = true;
  #   enableIPv6 = true;
  #   useDHCP = false;
  # };

  # +> Encrypted DNS
  services.dnscrypt-proxy2 = {
    enable = false;

    settings = {
      # +> GLOBAL SETTINGS
      # server_names = [ "cloudflare" ];
      listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
      max_clients = 250;
      ipv4_servers = true;
      ipv6_servers = true;
      dnscrypt_servers = true;
      doh_servers = false;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      force_tcp = false; # for Tor
      timeout = 5000;
      bootstrap_resolvers = [ "9.9.9.11:53" "1.1.1.1:53" ];
      ignore_system_dns = true;
      netprobe_timeout = 60;
      netprobe_address = "9.9.9.9:53";
      log_files_max_size = 10;
      log_files_max_age = 7;
      log_files_max_backups = 1;

      # +> FILTERS
      block_ipv6 = false;
      block_unqualified = true;
      block_undelegated = true;
      reject_ttl = 10;

      # +> DNS CACHE
      cache = true;
      cache_size = 4096;
      cache_min_ttl = 2400;
      cache_max_ttl = 86400;
      cache_neg_min_ttl = 60;
      cache_neg_max_ttl = 600;

      # +> SOURCES
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          "https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
        prefix = "";
      };
      # +> ANONYMIZED DNS RELAY
      sources.relays = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
          "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
          "https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md"
        ];
        cache_file = "relays.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
        prefix = "";
      };
      # +> ODOH SERVERS
      sources.odoh-servers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-servers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/odoh-servers.md"
          "https://ipv6.download.dnscrypt.info/resolvers-list/v3/odoh-servers.md"
        ];
        cache_file = "odoh-servers.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 24;
        prefix = "";
      };
      # +> ODOH RELAYS
      sources.odoh-relays = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-relays.md"
          "https://download.dnscrypt.info/resolvers-list/v3/odoh-relays.md"
          "https://ipv6.download.dnscrypt.info/resolvers-list/v3/odoh-relays.md"
        ];
        cache_file = "odoh-relays.md";
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 24;
        prefix = "";
      };
      # +> QUAD9
      sources.quad9-resolvers = {
        urls = ["https://www.quad9.net/quad9-resolvers.md"];
        minisign_key =
          "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
        cache_file = "quad9-resolvers.md";
        prefix = "quad9-";
      };

      # +> BROKEN IMPLEMENTATIONS
      broken_implementations = {
        fragments_blocked = [
          "cisco" "cisco-ipv6" "cisco-familyshield" "cisco-familyshield-ipv6" "cleanbrowsing-adult" "cleanbrowsing-adult-ipv6" "cleanbrowsing-family" "cleanbrowsing-family-ipv6" "cleanbrowsing-security" "cleanbrowsing-security-ipv6"
        ];
      };
    };
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
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    extraLocaleSettings = {
      LANG = "en_CA.UTF-8";
      LC_CTYPE = "en_CA.UTF-8";
      LC_NUMERIC = "en_CA.UTF-8";
      LC_TIME = "en_CA.UTF-8";
      LC_COLLATE = "en_CA.UTF-8";
      LC_MONETARY = "en_CA.UTF-8";
      LC_MESSAGES = "en_CA.UTF-8";
      LC_PAPER = "en_CA.UTF-8";
      LC_NAME = "en_CA.UTF-8";
      LC_ADDRESS = "en_CA.UTF-8";
      LC_TELEPHONE = "en_CA.UTF-8";
      LC_MEASUREMENT = "en_CA.UTF-8";
      LC_IDENTIFICATION = "en_CA.UTF-8";
    };
  };
  time.timeZone = "America/Edmonton";

  # +> PACKAGES
  environment.systemPackages = with pkgs; [
    wget
    unzip
    awscli2
    # nextdns
    # insomnia
    # parsecgaming
    # protonvpn-cli
    # popshell
    # looking-glass-client
    # lm_sensors
    # unite-shell
    # popshell-shortcuts
    python310
    python310Packages.pip
    python310Packages.setuptools
    python310Packages.wheel
    python310Packages.cfn-lint
    # import ./custom/twitch-cli.nix
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
    # parsecgaming = pkgs.callPackage ./custom/parsecgaming.nix {};
    # protonvpn-cli = pkgs.callPackage ./custom/protonvpn-cli.nix {};
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
  services.mysql = {
    enable = true;
    package = pkgs.mysql;
  };

  # +> USERS
  users.users.vieko = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "kvm" "libvirt" "plugdev" "audio"
    "plex" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      (builtins.readFile /home/vieko/.ssh/id_rsa.pub)
    ];
  };

  # +> CONFIG
  nix = {
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "root" "vieko" ];
      auto-optimise-store = true;
    };
    # package = pkgs.nixFlakes;
    # registry.nixpkgs.flake = "nixpkgs/nixos-unstable";
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';
  };
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-13.6.9"
    "electron-9.4.4"
  ];

  system.stateVersion = "22.11";

}

