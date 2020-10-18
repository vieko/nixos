" better escape
inoremap jk <ESC>
inoremap Jk <ESC>
inoremap JK <ESC>
inoremap jK <ESC>

" copy text to the end of the line (Y consistend with C and D)
nnoremap Y y$

" qq to record, q to stop recording, Q to replay
nnoremap Q @q

" prevent accidental undos under insert mode
inoremap <C-U> <C-G>u<C-U>

" no overwrite paste
xnoremap p "_dP

" some shortcut for git
nnoremap gca :Gcommit -a -v<CR>

" nnoremap gCc :Gcommit -v -- <C-R>=expand('%')<CR><CR>
nnoremap gp :call <SID>gpush()<CR>

" use tab to trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" gruvbox overrides for tpope/unimpaired
"nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
"nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
"nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
"nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
"nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
"nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" use `[c` and `]c` to navigate husks
nnoremap <buffer><silent> [c <Plug>(defx-git-prev)
nnoremap <buffer><silent> ]c <Plug>(defx-git-next)

" use `[w` and `]w` to navigate diagnostics
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)

" remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" avoid collision between <Tab> <C-i> with Karabiner
nnoremap <F6> <C-i> 

" Use <tab> for select selections ranges
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

xnoremap    <silent> * :call <SID>visualSearch('f')<CR>
xnoremap    <silent> # :call <SID>visualSearch('b')<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function!   s:visualSearch(direction)
  let       l:saved_reg = @"
  execute   'normal! vgvy'
  let       l:pattern = escape(@", '\\/.*$^~[]')
  let       l:pattern = substitute(l:pattern, "\n$", '', '')
  if        a:direction ==# 'b'
    execute 'normal! ?' . l:pattern . "\<cr>"
  elseif    a:direction ==# 'f'
    execute 'normal! /' . l:pattern . '^M'
  endif
  let       @/ = l:pattern
  let       @" = l:saved_reg
endfunction

function! s:gpush()
  if empty(get(b:, 'git_dir', '')) | return | endif
  let branch = system('git --git-dir='.b:git_dir.' rev-parse --abbrev-ref HEAD')
  if !v:shell_error && !empty(branch)
    let old_cwd = getcwd()
    execute 'lcd ' . fnamemodify(b:git_dir, ':h')
    execute 'Nrun git push origin '.substitute(branch, "\n$", '', ''). ' --force-with-lease'
  endif
endfunction

" coc-lists
" nnoremap <silent> \r  :<C-u>CocList -N mru -A<CR>
" nnoremap <silent> <space>h  :<C-u>CocList helptags<CR>
" nnoremap <silent> <space>g  :<C-u>CocList gstatus<CR>
" nnoremap <silent> <space>t  :<C-u>CocList buffers<cr>
" nnoremap <silent> <space>fy  :<C-u>CocList yank<cr>
" nnoremap <silent> <space>u  :<C-u>CocList snippets<cr>
" nnoremap <silent> <space>w  :exe 'CocList -A -I --normal --input='.expand('<cword>').' words -w'<CR>
" nnoremap <silent> <space>fl  :<C-u>CocList locationlist<CR>
" nnoremap <silent> <space>q  :<C-u>CocList quickfix<CR>
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
" nnoremap <silent> <space>e  :<C-u>CocListextensions<CR>
" nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
" nnoremap <silent> <space>fo  :<C-u>CocList outline<CR>
" nnoremap <silent> <space>s  :<C-u>CocList symbols<CR>
" nnoremap <silent> <space>r  :<C-u>CocList mru<CR>
" nnoremap <silent> <space>f  :<C-u>CocList files<CR>
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR> 
