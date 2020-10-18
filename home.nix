{ config, pkgs, ... }:

let
  defaultPkgs = with pkgs; [
    iftop
    iotop
    mtr
    htop
    ytop
    tree
    xclip
    killall
    ripgrep
    neofetch
  ];

  devPkgs = with pkgs; [
    alacritty
    # now-cli
    yarn
    xst
    nodejs
    gnumake
    coreutils
    binutils-unwrapped
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

  # TODO add Insomnia Core 2020
  appPkgs = with pkgs; [
    slack
    discord
    spotify
    razergenie
    libreoffice-fresh
    _1password-gui
  ];

  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy
    hub
    tig
  ];

in {
  programs.home-manager.enable = true;

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

    packages = defaultPkgs ++ devPkgs ++ shellPkgs ++ appPkgs ++ gitPkgs;

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
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
