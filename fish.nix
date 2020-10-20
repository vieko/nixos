{ config, lib, pkgs, ... }:
 
let
  dracula =  {
    name = "dracula";
    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "fish";
      rev = "805ee7a85bec579dc365c7245913d772cc57632b";
      sha256 = "02arvnmawg972p6ygi0fz6kvf1zhn72305bassz52cjs1904049y";
    };
  };
in {
  programs.fish = {
    enable = true;
    plugins = [ dracula ];
    # promptInit = ''
    #   eval (direnv hook fish)
    #   any-nix-shell fish --info-right | source
    # '';
    shellAliases = {
      # +> GENERAL
      y    = "xclip -selection clipboard -in";
      p    = "xclip -selection clipboard -out";
      # +> EXA
      l    = "exa -1";
      ll   = "exa -lg";
      la   = "LC_COLLATE=C exa -la";
      # +> TMUX
      ta   = "tmux attach";
      tl   = "tmux ls";
      tf   = "tmux find-window";
      # +> GIT
      ga   = "git add";
      gap  = "git add --patch";
      gb   = "git branch -av";
      gop  = "git open";
      gbl  = "git blame";
      gc   = "git commit";
      gcm  = "git commit -m";
      gca  = "git commit --amend";
      gcf  = "git commit --fixup";
      gcl  = "git clone";
      gco  = "git checkout";
      gcoo = "git checkout --";
      gf   = "git fetch";
      gi   = "git init";
      gl   = "git log --graph --pretty='format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset'";
      gll  = "git log --pretty='format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset'";
      gL   = "gl --stat";
      gp   = "git push";
      gpl  = "git pull --rebase --autostash";
      gs   = "git status --short .";
      gss  = "git status";
      gst  = "git stash";
      gr   = "git reset HEAD";
      grv  = "git rev-parse";
      # +> NOW
      now     = "~/.yarn/bin/vercel";
      vercel  = "~/.yarn/bin/vercel";
    };
    shellInit = '' set fish_greeting '';
  };
}