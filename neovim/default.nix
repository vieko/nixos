{ config, lib, pkgs, ... }:

let
  customPlugins = pkgs.callPackage ./custom.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
  };

  plugins = pkgs.vimPlugins // customPlugins;

  cocPlugins = with pkgs.vimPlugins; [
    coc-json
    coc-yank
    coc-git
    coc-css
    coc-lists
    coc-eslint
    coc-prettier
    coc-tsserver
    coc-emmet
    # coc-graphql
    # coc-tailwindcss
  ];

  optPlugins = with plugins; [{plugin = coc-nvim; optional = true;}];

  myVimPlugins = with plugins; [
    # == explorer
    defx-nvim
    defx-icons
    # == syntax
    vim-javascript
    typescript-vim
    vim-jsx-pretty
    vim-jsx-typescript
    vim-graphql
    vim-nix
    vim-tmux
    # == statusline
    lightline-vim
    # == interface
    vim-tmux-navigator
    vim-matchup
    vim-sneak
    limelight-vim
    emmet-vim
    # == editor
    vim-repeat
    vim-surround
    vim-commentary
    vim-unimpaired
    auto-pairs
    # == version jk
    vim-fugitive
    vim-rhubarb
    # == themes
    dracula-vim
  ] ++ cocPlugins ++ optPlugins;

  # TODO fix cursor disappears when entering insert mode
  base      = builtins.readFile ./config.vim;
  status    = builtins.readFile ./statusline.vim;
  explorer  = builtins.readFile ./explorer.vim;
  leader    = builtins.readFile ./leadermap.vim;
  plugs     = builtins.readFile ./plugins.vim;
  remap     = builtins.readFile ./remap.vim;
  abbrs     = builtins.readFile ./abbrs.vim;
  commands  = builtins.readFile ./commands.vim;
  auto      = builtins.readFile ./autocmd.vim;
  coc       = builtins.readFile ./coc.vim;
  vimConfig = base + status + explorer + leader + plugs + remap + abbrs +
  commands + auto + coc;
in {
  programs.neovim = {
    enable  = true;
    extraConfig = vimConfig;
    plugins = myVimPlugins;
    withNodeJs = true;
    withPython3 = true;
    package = pkgs.neovim-unwrapped;
  };

  xdg.configFile = {
    "nvim/coc-settings.json".text = builtins.readFile ./coc-settings.json;
  };
}
