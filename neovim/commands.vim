" Section: Commands
" -----------------

command! -nargs=0 Clean                                :call     s:Clean()
command! -nargs=0 Lookup                               :call     s:ShowDocumentation()
command! -nargs=0 Format                               :call     CocAction('format')
command! -nargs=0 Prettier                             :call     CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 OR                                   :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Q                                    :qa!
command! -nargs=0 V                                    :call     s:OpenTerminal()
command! -nargs=0 Cd                                   :call     s:Gcd()
command! -nargs=0 Commits                              :CocList  commits
command! -nargs=? Fold                                 :call     CocAction('fold', <f-args>)
command! -nargs=+ -complete=custom,s:GrepArgs          Rg        :exe 'CocList grep '.<q-args>

function! s:Gcd()
  if empty(get(b:, 'git_dir', '')) | return | endif
  execute 'cd '.fnamemodify(b:git_dir, ':h')
endfunction

function! s:OpenTerminal()
  let bn = bufnr('%')
  let dir = expand('%:p:h')
  if exists('b:terminal') && !buflisted(get(b:, 'terminal'))
    unlet b:terminal
  endif
  if !exists('b:terminal')
    belowright vs +enew
    exe 'lcd '.dir
    execute 'terminal'
    call setbufvar(bn, 'terminal', bufnr('%'))
  else
    execute 'belowright vertical sb '.get(b:, 'terminal', '')
    call feedkeys("\<C-l>", 'n')
  endif
endfunction

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

function! s:ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:Clean()
  let view = winsaveview()
  let ft = &filetype
  " replace tab with 2 space
  if index(['javascript', 'html', 'css', 'vim', 'php'], ft) != -1
    silent! execute "%s/\<tab>/  /g"
  endif
  " replace tailing comma
  if ft ==# 'javascript' || ft ==# 'typescript'
    silent! execute '%s/;$//'
  endif
  " remove tailing white space
  silent! execute '%s/\s\+$//'
  " remove windows `\r`
  call winrestview(view)
endfunction
