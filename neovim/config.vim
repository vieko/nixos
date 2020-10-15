" Section: General
" ----------------

" set autoread
" set autoindent
set autowrite
set backspace=2
" set belloff
set breakindent showbreak=\ +++
set clipboard+=unnamedplus
set cmdheight=2
set complete+=k
set complete-=t
set completeopt=menu,preview
" set completeopt=noinsert,noselect,menuone
set confirm
" set dictionary=+$XDG_DATA_HOME/vim/dict/words
set diffopt=vertical
set display+=lastline
set fillchars+=msgsep:-
set foldlevel=1
set foldtext=FoldText()
set formatoptions+=j
set formatoptions+=o
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" set grepprg=rg\ --color=never
" set guicursor=
set hidden
set history=2000
" set hlsearch
" set incsearch
set ignorecase
set inccommand=nosplit
set keywordprg=
" set laststatus=2
set lazyredraw
" set linebreak
set list
set listchars=precedes:<,extends:>
set listchars+=tab:»·,trail:·,eol:¬,nbsp:_
" set listchars+=space:·
" set mousehide
set mouse=a
set path+=**
set pumheight=15
set regexpengine=2
set scrolloff=3
set sessionoptions+=winsize
set sessionoptions+=resize
set sessionoptions-=blank
set sessionoptions+=localoptions
set sessionoptions+=globals
set shada=!,'100,<50,s10,h
set shell=/run/current-system/sw/bin/bash
set shortmess=aFcI
" set shortmess=atI
" set shortmess+=c
" set sidescroll=1
" set sidescrolloff=1
set signcolumn=yes
" set smartcase
set showtabline=0
set synmaxcol=300
set tabpagemax=10
" set tags+=gems.tags,stdlib.tags
" set tags=./tags,./../tags,./../../tags,./../../../tags,tags
set termguicolors
set title
" set ttimeout
set timeout timeoutlen=300 ttimeoutlen=100
set undofile
" set undodir=$XDG_DATA_HOME/vim/undo
set undolevels=500
set undoreload=500
set updatetime=100
set visualbell
" set viewdir=$XDG_DATA_HOME/vim/views
set viewoptions=cursor,folds,unix,slash
set whichwrap=b,s,h,l,<,>,[,]
" set wildmenu
set wildmode=list:longest,full
" set wildmode=longest:full,full
set wildignore+=tags,*.o,*~,.*.un~,*.pyc,*/tmp/*,*.swp
set wildignore+=*.so,*~,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignorecase

set nobackup
set nofoldenable
" set noimdisable
set nojoinspaces
set noruler
set noshowmode
set nostartofline
set noswapfile
" set nowrap
set nowritebackup

" Section: Editor
" ---------------

" set smarttab
set cursorline
set expandtab
set shiftround
set shiftwidth=2
set smartcase
set softtabstop=2
set tabstop=2
set textwidth=80
" set colorcolumn=+1
set number relativenumber
set numberwidth=5
set splitbelow
set splitright
set wrap
let g:html_indent_tags = 'li|p'
let &colorcolumn=join(range(81,999),",")

" Section: Visual
" ---------------
" let &t_8f='u;%lu;%lum'
" let &t_8b='u;%lu;%lum'

set background=dark
" let g:gruvbox_bold=0
" let g:gruvbox_italic=0
" let g:gruvbox_invert_selection=0
" let g:gruvbox_contrast_dark='medium'
" colorscheme gruvbox
colorscheme dracula

" Section: Functions
" ------------------

function! FoldText()
  let line = getline(v:foldstart)
  " lines that have been folded
  let nl = v:foldend - v:foldstart + 1
  let indent = repeat(' ', indent(v:foldstart))
  let endcol = &colorcolumn ? &colorcolumn : &textwidth
  let startcol = &columns < endcol ? &columns-4 : endcol
  return indent . substitute(line,"^ *","",1)
endfunction

