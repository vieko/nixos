{config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager  = "diff-so-fancy | less --tabs=2 -RFX";
    };
    mergetool = {
      cmd    = "nvim -f -c \"Gvdiffsplit!\" \"$MERGED\"";
      prompt = false;
    };
    merge.tool = "vimdiff";
    pull.rebase = false;
    credential.helper = "store --file ~/.git-credentials";
  };
in {
  programs.git = {
    enable  = true;
    extraConfig = gitConfig;
    # TODO add gpg signing keys
    #signing = {
    #  key = "";
    #  signByDefault = true;
    #};
    ignores = [
      "/node_modules"
      "/.next/"
      "/out/"
      "/build"
      ".DS_Store"
      "*.pem"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      ".env"
      ".env.local"
      ".env.development.local"
      ".env.test.local"
      ".env.production.local"
      ".vercel"
    ];
    userEmail = "vieko.franetovic@gmail.com";
    userName = "Vieko Franetovic";
  };
}
