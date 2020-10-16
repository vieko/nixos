{ config, lib, pkgs, ... }:
 
{
  programs.zsh =  {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history.extended = true;
    initExtra = ''
      ${builtins.readFile ./zsh/init.zsh}
      ${builtins.readFile ./zsh/config.zsh}
      ${builtins.readFile ./zsh/keybinds.zsh}
      ${builtins.readFile ./zsh/aliases.zsh}
      ${builtins.readFile ./zsh/prompt.zsh}
    '';
    sessionVariables = {
      ZDOTDIR     = "$XDG_CONFIG_HOME/zsh";
      ZSH_CACHE   = "$XDG_CACHE_HOME/zsh";
      ZGEN_DIR    = "$XDG_DATA_HOME/zsh";
      ZGEN_SOURCE = "$ZGEN_DIR/zgen.zsh";
      TMUX_HOME = "$XDG_CONFIG_HOME/tmux";
      TMUXIFIER = "$XDG_DATA_HOME/tmuxifier";
      TMUXIFIER_LAYOUT_PATH = "$XDG_DATA_HOME/tmuxifier";
    };
  };
}
