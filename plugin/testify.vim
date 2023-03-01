if exists('g:loaded_testify')
  finish
endif
let g:loaded_testify = 1

function! s:Testify(cmd) abort
  let g:testify_fail = 0
  call testify#clear()
  exec a:cmd
  let s:last_cmd = a:cmd
  call testify#run_all()

  if has('vim_starting')
    if get(g:, 'testify_fail', 0) == 0
      quit
    else
      cquit
    endif
  endif
endfunction

function! s:TestifyNearest() abort
  let cline = search('testify#it')
  redir => index
    silent exec ':0,.s/testify#it//n'
  redir END
  let index = str2nr(matchstr(index, '\d\+\ze\s\+match'))

  let g:testify_fail = 0
  call testify#clear()
  let ctx = expand('%:p')
  exec 'source' ctx
  call testify#run(ctx, index - 1)
endfunction

command! TestifyFile call s:Testify('source ' . expand('%'))
command! TestifyLast call s:Testify(s:last_cmd)
command! TestifySuite call s:Testify("for file in glob('t/**/*.vim',0,1) | exec 'source' file | endfor")
command! TestifyNearest call s:TestifyNearest()
