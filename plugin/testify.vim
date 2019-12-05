if exists('g:loaded_testify')
  finish
endif
let g:loaded_testify = 1

function! s:Testify(cmd)
  if !empty(a:cmd)
    let g:testify_fail = 0
    call testify#logger#clear()
    execute a:cmd
    let s:last_cmd = a:cmd
    call testify#logger#show()
    if has('vim_starting')
      " exec '!echo' get(g:, 'testify_fail', 0)
      if get(g:, 'testify_fail', 0) == 0
        quit
      else
        cquit
      endif
    endif
  else
    echo "Command cannot be empty"
  endif
endfunction

command! TestifyFile call s:Testify('source ' . expand('%'))
command! TestifyLast call s:Testify(s:last_cmd)
command! TestifySuite call s:Testify("for file in glob('t/**/*.vim',0,1) | exec 'source' file | endfor")
