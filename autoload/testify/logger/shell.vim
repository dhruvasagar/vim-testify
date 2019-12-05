function! testify#logger#shell#clear() abort
  redraw!
endfunction

function! testify#logger#shell#log(log) abort
  if a:log.type ==# 'success'
    silent! exec '!echo' a:log.msg
  elseif a:log.type ==# 'fail'
    silent! exec '!echo' a:log.msg
  elseif a:log.type ==# 'info'
    silent! exec '!echo' a:log.msg
  endif
endfunction
