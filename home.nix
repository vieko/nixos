{ config, pkgs, ... }:

let
  defaultPkgs = with pkgs; [
    htop
    ytop
    tree
    xclip
    killall
    ripgrep
    neofetch
  ];

  devPkgs = with pkgs; [
    xst
    nodejs
    gnumake
    coreutils
    binutils-unwrapped
  ];

  shellPkgs = with pkgs; [
    zsh
    bat
    exa
    fasd
    fd
    fzf
    tldr
    nix-zsh-completions
  ];

  # TODO add Insomnia Core 2020
  appPkgs = with pkgs; [
    slack
    discord
    spotify
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
    ./zsh.nix
    ./neovim
    ./tmux.nix
  ];

  xdg.enable = true;

  home = {
    username = "vieko";
    homeDirectory = "/home/vieko";
    stateVersion = "20.09";

    packages = defaultPkgs ++ devPkgs ++ appPkgs ++ gitPkgs;

    sessionVariables = {
      EDITOR = "nvim";
      BAT_THEME = "Dracula";
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
    
  };
}
