{ config, pkgs, hostName ? "unknown", ... }:

let
  baseImports = [
    ./git.nix
    #./zsh.nix
    ./tmux.nix
  ];
  devImports = [
    #./keybase.nix
  ];
  homeMachine = [
    #./redshift.nix
  ];
in {
  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config/nix".text = '' { allowUnfree = true; } '';

  programs.home-manager.enable = true;

  imports = baseImports ++ devImports ++ homeMachine;

  home.packages = with pkgs; [
    # DEPENDENCIES
    niv

    # BASIC TOOLS
    wget
    htop
    ytop
    tldr
    tree
    unzip
    killall
    neofetch

    # EDITOR
    (callPackage ./editor {})
    nodejs

    # DEV TOOLS
    coreutils
    gnumake
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
