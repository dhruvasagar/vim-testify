let s:testfile = 'testify_results.txt'
function! testify#logger#file#clear()
  call delete(s:testfile)
endfunction

function! testify#logger#file#log(log)
  if type(a:log.msg) == v:t_list
    call writefile(a:log.msg, s:testfile, 'a')
  else
    call writefile([a:log.msg], s:testfile, 'a')
  endif
endfunction
