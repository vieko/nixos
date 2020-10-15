" vim-easymotion
" augroup HackCocConflict
"   autocmd!
"   au InsertEnter *.js CocEnable
"   au InsertLeave *.js CocDisable
" augroup END

function! s:map(keys, name)
  let l:center=get(g:, 'LoupeCenterResults', 1)
  let l:center_string=l:center ? 'zz' : ''

  let l:case=get(g:, 'LoupeCaseSettingsAlways', 1)

  if a:keys ==# '#'
    let l:action=l:case ? ":let @/='\\V\\<'.loupe#private#escape(expand('<cword>')).'\\>'<CR>:let v:searchforward=0<CR>n" : '#'
  elseif a:keys ==# '*'
    let l:action=l:case ? ":let @/='\\V\\<'.loupe#private#escape(expand('<cword>')).'\\>'<CR>:let v:searchforward=1<CR>n" : '*'
  elseif a:keys ==# 'N'
    let l:action='N'
  elseif a:keys ==# 'g#'
    let l:action=l:case ? ":let @/='\\V'.loupe#private#escape(expand('<cword>'))<CR>:let v:searchforward=0<CR>n" : 'g#'
  elseif a:keys ==# 'g*'
    let l:action=l:case ? ":let @/='\\V'.loupe#private#escape(expand('<cword>'))<CR>:let v:searchforward=1<CR>n" : 'g*'
  elseif a:keys ==# 'n'
    let l:action='n'
  endif

  if !hasmapto('<Plug>(Loupe' . a:name . ')')
    execute 'nmap <silent> ' . a:keys . ' <Plug>(Loupe' . a:name . ')'
  endif

  execute 'nnoremap <silent> <Plug>(Loupe' . a:name . ')' .
    \ ' ' .
    \ l:action .
    \ 'zv' .
    \ l:center_string .
    \ ':call loupe#hlmatch()<CR>'
endfunction

" vim-sneak
let g:sneak#label=1
let g:sneak#s_next=1
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" vim-matchup
let g:matchup_matchparen_deferred=1
let g:matchup_matchparen_enabled=0
let g:matchup_matchparen_offscreen={}

" defx
let g:defx_icons_enable_syntax_highlight = 0

" limelight
let g:limelight_conceal_guifg = '#3c3836'
let g:limelight_paragraph_span = 0

" autopairs
let g:AutoPairsShortcutToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''
