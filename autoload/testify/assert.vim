function! s:assert(cond, ...) abort
  let fail_msg = a:0 ? a:1 : 'Failed'
  if !a:cond
    throw fail_msg
  endif
endfunction

function! testify#assert#assert(cond)
  call s:assert(cond)
endfunction

function! testify#assert#equals(actual, expected)
  let cond = a:actual ==# a:expected
  call s:assert(cond, 'Expected ' . a:actual . ' to equal ' . a:expected)
endfunction

function! testify#assert#not_equals(actual, expected)
  let cond = a:actual !=# a:expected
  call s:assert(cond, 'Expected ' . a:actual . ' to not equal ' . a:expected)
endfunction

function! testify#assert#matches(actual, regexp)
  let cond = a:actual =~# a:regexp
  call s:assert(cond, 'Expected ' . a:actual . ' to match regexp ' . a:regexp)
endfunction

function! testify#assert#not_matches(actual, regexp)
  let cond = a:actual !~# a:regexp
  call s:assert(cond, 'Expected ' . a:actual . ' to not match regexp ' . a:regexp)
endfunction

function! testify#assert#empty(actual)
  let cond = empty(actual)
  call s:assert(cond, 'Expected ' . a:actual . ' to be empty')
endfunction

function! testify#assert#not_empty(actual)
  let cond = !empty(actual)
  call s:assert(cond, 'Expected ' . a:actual . ' to not be empty')
endfunction

function! testify#assert#raise_exception(funcref, exception)
  try
    call funcref()
  exec 'catch' a:exception
    call s:assert(1, 'Expected function to raise exception ' . a:exception)
  endtry
endfunction

function! testify#assert#not_raise_exception(funcref, exception)
  try
    call funcref()
    call s:assert(1, 'Expected function to not raise exception ' . a:exception)
  exec 'catch' a:exception
  endtry
endfunction
