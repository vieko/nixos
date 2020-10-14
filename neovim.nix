{ pkgs, ... }:

{
  programs.neovim = {
    enable  = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [vim-nix dracula-vim];
    withNodeJs = true;
    withPython = true;
    withPython3 = true;
  };
}
