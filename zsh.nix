{ config, lib, pkgs, ... }:
 
{
  programs.zsh =  {
    enable = true;
    oh-my-zsh = { enable = true; };
    enableCompletion = true;
    enableAutosuggestions = true;
    # initExtra = ''
    #   ${builtins.readFile ./zsh/init.zsh}
    #   ${builtins.readFile ./zsh/config.zsh}
    #   ${builtins.readFile ./zsh/keybinds.zsh}
    #   ${builtins.readFile ./zsh/aliases.zsh}
    #   ${builtins.readFile ./zsh/prompt.zsh}
    # '';
  };
}
