" Section: Common Errors
" ----------------------

iabbrev thsi this
iabbrev slient silent
iabbrev cosnt const

" Section: Shortcuts
" ------------------

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
  \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
  \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('C', 'CocConfig')
call SetupCommandAbbrs('CR', 'CocRestart')

call SetupCommandAbbrs('T', 'tabe')

call SetupCommandAbbrs('Gd', 'Gvdiff')
call SetupCommandAbbrs('Gst', 'Gstatus')
call SetupCommandAbbrs('Gp', 'Gpush')
call SetupCommandAbbrs('Gci', 'Gcommit -v')
call SetupCommandAbbrs('Gca', 'Gcommit -a -v')
call SetupCommandAbbrs('Gcaa', 'Gcommit --amend -a -v')
call SetupCommandAbbrs('Gco', 'Gcheckout')
call SetupCommandAbbrs('Grm', 'Gremove')
call SetupCommandAbbrs('Gmv', 'Gmove')

call SetupCommandAbbrs('L', 'CocList')
call SetupCommandAbbrs('F', 'Format')
