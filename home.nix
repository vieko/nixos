{ config, pkgs, hostName ? "unknown", ... }:

let
  baseImports = [
    ./git.nix
  ];
  devImports = [
  ];
  homeMachine = [
  ];
in {
  nixpkgs.config.allowUnfree = true;
  home.file.".config/nixpkgs/config/nix".text = '' { allowUnfree = true; } '';

  programs.home-manager.enable = true;

  imports = baseImports ++ devImports ++ homeMachine;

  home.packages = with pkgs; [
    wget
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
