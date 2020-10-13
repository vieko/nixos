{ config, lib, pkgs, ... }:

{
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Vieko Franetovic";
    userEmail = "vieko.franetovic@gmail.com";
    aliases = {
      s = "status --short .";
    };
    extraConfig = {
      code.editor = "nvim";
      credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "false";
    };
  };
}
