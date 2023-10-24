function! testify#logger#echo#clear() abort
  redraw!
endfunction

function! testify#logger#echo#log(log) abort
  if type(a:log.msg) ==# v:t_list
    for m in a:log.msg
      call testify#logger#echo#log({ 'type': a:log.type, 'msg': m })
    endfor
  elseif a:log.type ==# 'success'
    silent! echohl Special | echo a:log.msg | echohl None
  elseif a:log.type ==# 'fail'
    silent! echohl Error | echo a:log.msg | echohl None
  elseif a:log.type ==# 'info'
    silent! echohl Normal | echo a:log.msg | echohl None
  endif
endfunction
