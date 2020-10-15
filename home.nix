{ config, pkgs, ... }:

let
  defaultPkgs = with pkgs; [
    fd
    # exa
    htop
    ytop
    tldr
    tree
    xclip
    killall
    ripgrep
    neofetch
    # prettyping
  ];

  devPkgs = with pkgs; [
    nodejs
    gnumake
    coreutils
    binutils-unwrapped
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
    #./zsh.nix
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
    broot = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
