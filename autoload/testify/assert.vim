if exists('g:autoloaded_assert')
  finish
endif
let g:autoloaded_assert = 1

function! s:assert(cond, fail_msg) abort
  if !a:cond
    throw a:fail_msg
  endif
endfunction

function! testify#assert#assert(cond)
  call s:assert(cond, 'Failed')
endfunction

function! testify#assert#equals(actual, expected)
  let cond = a:actual ==# a:expected
  call s:assert(cond, 'Expected ' . a:actual . ' to equal ' . a:expected)
endfunction

function! testify#assert#not_equals(actual, expected)
  let cond = a:actual !=# a:expected
  call s:assert(cond, 'Expected ' . a:actual . ' to not equal ' . a:expected)
endfunction
