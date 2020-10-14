{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [ copycat prefix-highlight yank open ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
