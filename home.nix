{ config, pkgs, hostName ? "unknown", ... }:

let
  baseImports = [
    ./git.nix
    #./zsh.nix
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
    unzip
    killall

    # EDITOR
    #(callPackage ./editor {})
    nodejs

    # DEV TOOLS
    coreutils
    gnumake
  ];
    programs.neovim = {
      enable  = true;
      plugins = with pkgs.vimPlugins; [vim-nix dracula-vim];
      extraConfig = builtins.readFile ./config.vim;
    };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
