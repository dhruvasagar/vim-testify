if exists('g:autoloaded_testify')
  finish
endif
let g:autoloaded_testify = 1

function! testify#it(msg, func)
  try
    let result = a:func()
    call testify#logger#success('√ ' . a:msg)
  catch
    call testify#logger#fail('✗ ' . a:msg)
    call testify#logger#fail("\t" . v:exception)
  endtry
endfunction
