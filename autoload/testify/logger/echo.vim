function! testify#logger#echo#clear() abort
  redraw!
endfunction

function! testify#logger#echo#log(log) abort
  if log.type ==# 'success'
    echohl Special | echo a:msg | echohl None
  elseif log.type ==# 'fail'
    echohl Error | echo a:msg | echohl None
  elseif log.type ==# 'info'
    echohl Normal | echo a:msg | echohl None
  endif
endfunction
