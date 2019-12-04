function! testify#it(msg, func)
  try
    let result = a:func()
    call testify#logger#success('√ ' . a:msg)
  catch
    call testify#logger#fail('✗ ' . a:msg)
    call testify#logger#fail("\t" . v:exception)
    call testify#logger#throwpoint("\t\t")
  endtry
endfunction
