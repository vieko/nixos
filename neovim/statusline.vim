" Section: Statusline
" -------------------

" Lightline
  let g:lightline = {
    \ 'colorscheme': 'dracula',
    \ 'active': {
    \   'left': [
    \             ['mode', 'paste'],
    \             ['fugitive', 'filename'],
    \             ['process']
    \           ],
    \   'right': [
    \             ['cocerror','cocwarning','lineinfo'],
    \             ['percent'],
    \             ['fileformat', 'fileencoding', 'filetype']
    \           ]
    \ },
    \ 'component': {
    \   'lineinfo': '%3l:%-2v', 'line': '%l', 'column': '%c', 'close': '%999X X ', 'winnr': '%{winnr()}'
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive',
    \   'filename': 'LightlineFilename',
    \   'process': 'LightlineRunningProcess',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding',
    \   'mode': 'LightlineMode'
    \ },
    \ 'component_expand': {
    \   'cocerror': 'LightlineStatusError',
    \   'cocwarning': 'LightlineStatusWarning',
    \ },
    \ 'component_type': {
    \   'cocerror': 'error',
    \   'cocwarning': 'warning',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '▪', 'right': '▪' }
    \ }

  function! LightlineMode()
    let fname = expand('%:t')
    return &ft == 'help' ? 'HELP' : &ft == 'defx' ? 'DEFX' : winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  endfunction

  function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
  endfunction

  function! LightlineModified()
    return &ft =~ 'help\|defx' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! LightlineReadonly()
    return &readonly && &filetype !~# '\v(help|defx)' ? '' : ''
  endfunction

  function! LightlineFilename()
    return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
    \ (&ft == 'defx' ? '' :
    \ '' != expand('%:t') ? ''.expand('%:p:h:t').' ▪ '.expand('%:t') : '[No Name]') .
    \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
  endfunction

  function! LightlineFugitive()
    if &ft !~? 'defx' && exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ' '.branch : ''
    endif
    return ''
  endfunction

  function! LightlineStatusError() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
      call add(msgs, 'E:' . info['error'])
    endif
    return join(msgs, ' ')
  endfunction

  function! LightlineStatusWarning() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'warning', 0)
      call add(msgs, 'W:' . info['warning'])
    endif
    return join(msgs, ' ')
  endfunction

  function! LightlineRunningProcess() abort
    return &filetype !~# '\v(help|defx)' ? get(g:, 'coc_status', '') : ''
  endfunction
