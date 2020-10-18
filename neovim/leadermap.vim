" Section: Keybindings
" --------------------

" better leader
let mapleader=" "

" LEADER -
"        SPC     → find file in project
         nnoremap <leader><leader> :<C-u>CocList files -F --hidden<CR>
"        '       → resume last search
         nnoremap <leader>' :<C-u>CocListResume<CR>
"        *       → search for symbol in project
         nnoremap <leader>* :<C-u>CocList symbols<CR>
"        .       → find recent file
         nnoremap <leader>. :<C-u>CocList mru<CR>
"        <       → switch buffer
         nnoremap <leader>< :<C-u>CocList buffers<CR>
"        `       → switch to last buffer
         nnoremap <leader>` <C-^>
"        RET     → clear highlights 
         nnoremap <silent><leader><CR> :noh<CR>
"        SEARCH  /
"                d      → find file in current directory
                 nnoremap <leader>/d :<C-u>CocList files --hidden<CR>
"                b      → search current buffer
                 nnoremap <leader>/b :<C-u>CocList lines<CR>
"                k      → look up in local docset
                 nnoremap <leader>/k :silent! :Lookup<CR>
"                p      → search project
                 nnoremap <leader>/p :Rg<space>
"                g      → search selected
                 vnoremap <leader>/g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
                 nnoremap <leader>/g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
"        BUFFER  b
"                b      → search current buffer
                 nnoremap <leader>bb :<C-u>CocList lines<CR>
"                B      → switch buffer
                 nnoremap <leader>bB :<C-u>CocList buffers<CR>
"                N      → new empty buffer
                 nnoremap <leader>bN :enew<CR>
"                d      → kill buffer
                 nnoremap <leader>bd :bd<CR>
"                k      → kill buffer
                 nnoremap <leader>bk :bd<CR>
"                n      → next buffer
                 nnoremap <leader>bn :<C-u>CocNext<CR>
"                p      → previous buffer
                 nnoremap <leader>bp :<C-u>CocPrev<CR>
"                s      → save buffer
                 nnoremap <leader>bs :w!<CR>
"                w      → save buffer
                 nnoremap <leader>bw :w!<CR>
"                r      → rename word
                 nmap <leader>br <Plug>(coc-rename)
"                f      → format buffer
                 nnoremap <leader>bf :Format<CR>
"                g      → search selected
                 vnoremap <leader>bg :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
                 nnoremap <leader>bg :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
"                o      → organize import
                 nnoremap <leader>bo :OR<CR>
"        CODE    c
"                W      → clean up document
                 nnoremap <leader>cW :Clean<CR>
"                d      → jump to definition
                 nmap <silent><leader>cd <Plug>(coc-definition)
"                f      → format selection
                 xmap <leader>cf <Plug>(coc-format-selected)
                 nmap <leader>cf <Plug>(coc-format-selected)
"                k      → jump to documentation
                 nnoremap <silent><leader>ck :silent! :Lookup<CR>
"                w      → delete trailing whitespace
                 nnoremap <leader>cw :Clean<CR>
"                x      → list errors
                 nnoremap <silent><leader>cx :<C-u>CocList diagnostics<CR>
"        FILES   f
"                .      → find file
                 nnoremap <leader>f. :<C-u>CocList files -F --hidden<CR>
"                /      → find file from here
                 nnoremap <leader>f/ :<C-u>CocList files --hidden<CR>
"                V      → browser neovim config
"                R      → recent files
                 nnoremap <leader>fR :<C-u>CocList mru<CR>
"                v      → find file in neovim config
"                r      → recent files
                 nnoremap <leader>fr :<C-u>CocList mru<CR>
"                s      → save fle
                 nnoremap <leader>fs :w!<CR>
"                y      → yank filename
"        GIT     g
"        OPEN    o
"                p      → project sidebar
                 nnoremap <silent><leader>op :call DefxOpen()<CR>
"        PROJECT p
"                P      → find file in project
                 nnoremap <leader>pP :<C-u>CocList files -F --hidden<CR>
"                /      → search project
                 nnoremap <leader>p/ :Rg<space>
"                d      → change pwd to current working directory
                 nnoremap <leader>pd :cd %:p:h<CR>:pwd<CR>
"        HELP    h
"                r      → reload vim
                 nnoremap <leader>hr :source /etc/dotfiles/neovim/config.vim<CR>
"                k      → look up in the docset
                 nnoremap <silent><leader>hh :silent! :Lookup<CR>
"                i      → highlight group under cursor
                 nnoremap <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                       \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                       \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"                l      → toggle limelight
                 nnoremap <leader>hl :Limelight!!<CR> 
"                c      → toggle ruler 
                 nnoremap <leader>hc :execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>
"                f      → toggle infinite ruler
                 nnoremap <leader>hf :execute (&colorcolumn == "" ? "let &colorcolumn=join(range(81,999),\",\")" : "set colorcolumn=\"\"")<CR>

nnoremap <silent> <leader>pp "0p

" remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)

" fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" nmap <leader>x  <Plug>(coc-cursors-operator)
" nmap <leader>rf <Plug>(coc-refactor)
" nmap <leader>ca <Plug>(coc-codelens-action)
" nmap <leader>di <Plug>(coc-diagnostic-info)
" nmap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
" nmap <leader>dr <Plug>(coc-diagnostic-related)

" replace all of current word
" nnoremap <leader>rs :%s/\<<C-r><C-w>\>//g<left><left>

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

function! s:Open()
  let res = CocAction('openLink')
  if res | return | endif
  let line = getline('.')
  " match url
  let url = matchstr(line, '\vhttps?:\/\/[^)\]''" ]+')
  if !empty(url)
    let output = system('open '. url)
  else
    let mail = matchstr(line, '\v([A-Za-z0-9_\.-]+)\@([A-Za-z0-9_\.-]+)\.([a-z\.]+)')
    if !empty(mail)
      let output = system('open mailto:' . mail)
    else
      let output = system('open ' . expand('%:p:h'))
    endif
  endif
  if v:shell_error && output !=# ""
    echoerr output
  endif
endfunction
