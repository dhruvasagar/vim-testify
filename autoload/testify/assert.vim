function! s:assert(cond, ...) abort
  let fail_msg = a:0 ? a:1 : 'Failed'
  if !a:cond
    throw fail_msg
  endif
endfunction

function! testify#assert#assert(cond) abort
  call s:assert(a:cond)
endfunction

function! testify#assert#equals(actual, expected) abort
  let cond = a:actual ==# a:expected
  call s:assert(cond,
        \ printf('Expected "%s" to equal "%s"', a:actual, a:expected))
endfunction

function! testify#assert#not_equals(actual, expected) abort
  let cond = a:actual !=# a:expected
  call s:assert(cond,
        \ printf('Expected "%s" to not equal "%s"', a:actual, a:expected))
endfunction

function! testify#assert#matches(actual, regexp) abort
  let cond = a:actual =~# a:regexp
  call s:assert(cond,
        \ printf('Expected "%s" to match regexp "%s"', a:actual, a:regexp))
endfunction

function! testify#assert#not_matches(actual, regexp) abort
  let cond = a:actual !~# a:regexp
  call s:assert(cond,
        \ printf('Expected "%s" to not match regexp "%s"', a:actual, a:regexp))
endfunction

function! testify#assert#empty(actual) abort
  let cond = empty(a:actual)
  call s:assert(cond, printf('Expected "%s" to be empty', a:actual))
endfunction

function! testify#assert#not_empty(actual) abort
  let cond = !empty(a:actual)
  call s:assert(cond, printf('Expected "%s" to not be empty', a:actual))
endfunction

function! testify#assert#raise_exception(funcref, exception) abort
  try
    call a:funcref()
  catch
    let cond = a:exception ==# v:exception
    return s:assert(cond,
          \ printf('Expected function to raise exception "%s", but got "%s"',
          \        a:exception,
          \        v:exception))
  endtry
  call s:assert(0,
        \ printf('Expected function to raise exception "%s", but none was raised',
        \        a:exception))
endfunction

function! testify#assert#not_raise_exception(funcref) abort
  try
    call a:funcref()
  catch
    return s:assert(0,
          \ printf('Expected function to not raise exception but got "%s"',
          \        v:exception))
  endtry
endfunction
