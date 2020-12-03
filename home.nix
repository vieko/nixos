{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

  unstablePkgs = with unstable; [
    mongodb-compass
    obsidian
    # _1password-gui
  ];

  defaultPkgs = with pkgs; [
    iftop
    iotop
    nvtop
    mtr
    htop
    ytop
    tree
    xclip
    killall
    ripgrep
    neofetch
    lm_sensors
    # rrdtool
    psensor
    # usbutils
    # input-fonts
  ];

  devPkgs = with pkgs; [
    yarn
    nodejs
    gnumake
    coreutils
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
    slack
    # steam
    # wine
    # winetricks
    discord
    spotify
    alacritty
    jetbrains.datagrip
    razergenie
    torrential
    keybase-gui
    libreoffice-fresh
    gimp
    appimage-run
    firefox-devedition-bin
  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy
    gh
    hub
    tig
  ];

in {
  programs.home-manager.enable = true;

  # nixpkgs.overlays = [
  #   (import ./overlays/lm-sensors.nix)
  # ];

  imports = [
    ./chromium.nix
    ./git.nix
    ./fish.nix
    ./neovim
    ./tmux.nix
  ];

  home = {
    username = "vieko";
    homeDirectory = "/home/vieko";
    stateVersion = "20.09";

    packages = unstablePkgs ++ defaultPkgs ++ devPkgs ++ shellPkgs ++ appPkgs ++ gitPkgs;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # +> PROGRAMS
  programs = {
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
    gpg = {
      enable = true;
    };
    ssh = {
      enable = true;
    };
    # firefox = {
    #   enable = true;
    #   profiles.options.userChrome = ''
    #     .scroll-styled-h, .scroll-styled-v, html {
    #       scrollbar-color: #282a36 rgba(255, 255, 255, .0);
    #       scrollbar-width: thin;
    #     }
    #   '';
    # };
    alacritty ={
      enable = true;
      settings = {
        env = {
          TERM = "alacritty";
        };
        window = {
          title = "SUMMONING DEMONS";
          dynamic_title = false;
          padding = {
            x = 8;
            y = 8;
          };
        };
        font = {
          size = 11;
          normal = {
            family = "Input Mono Narrow";
            style = "Regular";
          };
          bold = {
            family = "Input Mono Narrow";
            style = "Bold";
          };
          italic = {
            family = "Input Mono Narrow";
            style = "Italic";
          };
          bold_italic = {
            family = "Input Mono Narrow";
            style = "Bold Italic";
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
      enable = true;
    };
    keybase = {
      enable = true;
    };
  };
}
