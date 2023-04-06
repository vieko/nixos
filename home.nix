{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-13.6.9"
        "electron-12.2.3"
        "electron-9.4.4"
        "python-2.7.18.6"
      ];
    };
  };

  unstablePkgs = with unstable; [
    # beekeeper-studio
    # clamav
    # godot_4
    # tiled
    aseprite-unfree
    gam
    # nextdns
    # fractal
    parsec-bin
    signal-desktop
    prisma-engines
    nodePackages.prisma
    hyper
    httrack
    remmina
    eyedropper
    insomnia
    pscale
    vscode
    obsidian
    syncthing
    python310Packages.awscrt
    _1password-gui
    # dconf2nix
    standardnotes
    ngrok
    gh
    onlyoffice-bin
    authy
    sabnzbd
    ventoy-bin
    nodePackages.vercel
  ];

  defaultPkgs = with pkgs; [
    etcher
    protonvpn-gui
    protonvpn-cli
    # pico8-shell
    # anbox
    hydra-check
    via
    iftop
    iotop
    # nvtop
    mtr
    bottom
    htop
    tree
    xclip
    # etcher
    # woeusb
    unrar
    par2cmdline
    killall
    ripgrep
    neofetch
    lm_sensors
    pick-colour-picker
    gnome.dconf-editor
    # rrdtool
    psensor
    # usbutils
    # input-fonts
    v4l-utils
    guvcview
    ffmpeg
    keepassxc


    # TODO: figure out custom buttons for Viper Ultimate
    # xorg.xev
    # xvkbd
    xbindkeys
    xbindkeys-config
  ];

  devPkgs = with pkgs; [
    heroku
    # nodejs-16_x
    nodejs-18_x
    nodePackages.typescript
    yarn
    whois
    docker-compose
    gnumake
    dnsutils
    coreutils
    # unstable.nodePackages.prisma
    # unstable.prisma-engines
    # TODO: figure how to add latest vercel via nix
    # now-cli
  ];

  shellPkgs = with pkgs; [
    bat
    exa
    fasd
    fd
    fzf
    tldr
    any-nix-shell
  ];

  appPkgs = with pkgs; [
    # vscode
    discord
    # gnome-feeds
    google-chrome
    # insomnia
    slack
    audacity
    # standardnotes
    # steam
    # wine
    # winetricks
    # cozy
    # pan
    # discord
    # audacity
    pulseeffects-legacy
    spotify
    alacritty
    razergenie
    # torrential
    # transmission
    transmission-gtk
    # keybase-gui
    # libreoffice-fresh
    # gimp
    appimage-run
  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy
    hub
    tig
  ];

in {
  programs.home-manager.enable = true;

  # nixpkgs.overlays = [
  #   (import ./overlays/lm-sensors.nix)
  # ];

  # nixpkgs.overlays = [
  #   (self: super: { discord = super.discord.overrideAttrs (_: {
  #     src = builtins.fetchTarball
  #     "https://github.com/reedrw/nixpkgs/archive/refs/heads/update-discord.tar.gz";
  #   });})
  # ];

  imports = [
    # ./chromium.nix
    # ./pico.nix
    ./git.nix
    ./fish.nix
    ./neovim
    ./tmux.nix
  ];

  home = {
    username = "vieko";
    homeDirectory = "/home/vieko";
    stateVersion = "22.11";

    packages = unstablePkgs ++ defaultPkgs ++ devPkgs ++ shellPkgs ++ appPkgs ++ gitPkgs;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  gtk = {
    enable = true;
    theme.name = "Pop-dark";
    iconTheme.name = "Pop";
  };

  # +> PROGRAMS
  programs = {
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        # enableFlakes = true;
      };
    };
    bat = { 
      enable = true; 
      config = {
        theme  = "Dracula";
      };
    };
    # direnv = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   enableNixDirenvIntegration = true;
    # };
    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--color=dark"
        "--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f"
        "--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
      ];
    };
    go = {
      enable = true;
    };
    gpg = {
      enable = true;
    };
    ssh = {
      enable = true;
    };
    firefox = {
      enable = true;
      profiles.options.userChrome = ''
        .scroll-styled-h, .scroll-styled-v, html {
          scrollbar-color: #282a36 rgba(255, 255, 255, .0);
          scrollbar-width: thin;
        }
      '';
    };
    obs-studio = {
      enable = false;
    };
    alacritty ={
      enable = true;
      settings = {
        env = {
          TERM = "alacritty";
        };
        window = {
          title = "♜";
          dynamic_title = false;
          padding = {
            x = 8;
            y = 8;
          };
        };
        font = {
          size = 11;
          normal = {
            family = "MonoLisa M23";
            style = "Medium";
          };
          bold = {
            family = "MonoLisa M23";
            style = "Semibold";
          };
          italic = {
            family = "MonoLisa M23";
            style = "Medium Italic";
          };
          bold_italic = {
            family = "MonoLisa M23";
            style = "Semibold Italic";
          };
        };
        colors = {
          primary = {
            background = "0x282a36";
            foreground = "0xf8f8f2";
          };
          cursor = {
            text = "0x44475a";
            # cursor = "0xf8f8f2"; # white
            cursor = "0xf1fa8c";
          };
          selection = {
            text = "0xf8f8f2";
            background = "0x44475a";
          };
          normal = {
            black   =  "0x000000";
            red     =  "0xff5555";
            green   =  "0x50fa7b";
            yellow  =  "0xf1fa8c";
            blue    =  "0xbd93f9";
            magenta =  "0xff79c6";
            cyan    =  "0x8be9fd";
            white   =  "0xbfbfbf";
          };
          bright = {
            black   =  "0x4d4d4d";
            red     =  "0xff6e67";
            green   =  "0x5af78e";
            yellow  =  "0xf4f99d";
            blue    =  "0xcaa9fa";
            magenta =  "0xff92d0";
            cyan    =  "0x9aedfe";
            white   =  "0xe6e6e6";
          };
          dim = {
            black   =  "0x14151b";
            red     =  "0xff2222";
            green   =  "0x1ef956";
            yellow  =  "0xebf85b";
            blue    =  "0x4d5b86";
            magenta =  "0xff46b0";
            cyan    =  "0x59dffc";
            white   =  "0xe6e6d1";
          };
          indexed_colors = [];
        };
      };
    };
  };
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
    kbfs = {
      enable = false;
    };
  };
}
