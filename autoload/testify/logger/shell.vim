function! testify#logger#shell#clear() abort
  redraw!
endfunction

function! testify#logger#shell#log(log) abort
  if a:log.type ==# 'fail'
    silent! exec '!>&2 echo' a:log.msg
  else
    if type(a:log.msg) ==# v:t_list
      for msg in a:log.msg
        call testify#logger#shell#log({ 'type': a:log.type, 'msg': msg })
      endfor
    else
      silent! exec '!echo' a:log.msg
    endif
  endif
endfunction
