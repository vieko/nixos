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
    ./zsh.nix
    ./fish.nix
    ./neovim
    ./tmux.nix
  ];

  #xdg.enable = true;

  home = {
    username = "vieko";
    homeDirectory = "/home/vieko";
    stateVersion = "20.09";

    packages = defaultPkgs ++ devPkgs ++ shellPkgs ++ appPkgs ++ gitPkgs;

    sessionVariables = {
      # == defaults
      EDITOR = "nvim";
      # XDG_CACHE_HOME  = "$HOME/.cache";
      # XDG_CONFIG_HOME = "$HOME/.config";
      # XDG_DATA_HOME   = "$HOME/.local/share";
      # XDG_BIN_HOME    = "$HOME/.local/bin";
      # == zsh
      # ZDOTDIR     = "$XDG_CONFIG_HOME/zsh";
      # ZSH_CACHE   = "$XDG_CACHE_HOME/zsh";
      # ZGEN_DIR    = "$XDG_DATA_HOME/zsh";
      # ZGEN_SOURCE = "$ZGEN_DIR/zgen.zsh";
      # == tmux
      # TMUX_HOME = "$XDG_CONFIG_HOME/tmux";
      # TMUXIFIER = "$XDG_DATA_HOME/tmuxifier";
      # TMUXIFIER_LAYOUT_PATH = "$XDG_DATA_HOME/tmuxifier";
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
