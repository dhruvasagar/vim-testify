function! s:TestEqualsSuccess() abort
  call testify#assert#not_raise_exception(
        \ function('testify#assert#equals', [1, 1]))
endfunction
call testify#it('testify#assert#equals should succeed when arguments are equal',
      \ function('s:TestEqualsSuccess'))

function! s:TestEqualsFailure() abort
  call testify#assert#raise_exception(
        \ function('testify#assert#equals', [1, 2]),
        \ 'Expected "1" to equal "2"')
endfunction
call testify#it('testify#assert#equals should raise exception when arguments are not equal',
      \ function('s:TestEqualsFailure'))

function! s:TestifyNotEqualsSuccess() abort
  call testify#assert#not_raise_exception(
        \ function('testify#assert#not_equals', [1, 2]))
endfunction
call testify#it('testify#assert#not_equals should succeed when arguments are not equal',
      \ function('s:TestifyNotEqualsSuccess'))

function! s:TestifyNotEqualsFailure() abort
  call testify#assert#raise_exception(
        \ function('testify#assert#not_equals', [1, 1]),
        \ 'Expected "1" to not equal "1"')
endfunction
call testify#it('testify#assert#not_equals should raise exception when arguments are equal',
      \ function('s:TestifyNotEqualsFailure'))

function! s:TestifyMatchesSuccess() abort
  call testify#assert#not_raise_exception(
        \ function('testify#assert#matches', ['match 1 2 3', '^match.*']))
endfunction
call testify#it('testify#assert#matches should not raise exception when arguments match',
      \ function('s:TestifyMatchesSuccess'))

function! s:TestifyMatchesFailure() abort
  call testify#assert#raise_exception(
        \ function('testify#assert#matches', ['match 1 2 3', '^mitch.*']),
        \ 'Expected "match 1 2 3" to match regexp "^mitch.*"')
endfunction
call testify#it('testify#assert#matches should raise exception when arguments do not match',
      \ function('s:TestifyMatchesFailure'))

function! s:TestifyNotMatchesSuccess() abort
  call testify#assert#not_raise_exception(
        \ function('testify#assert#not_matches', ['match 1 2 3', '^mitch.*']))
endfunction
call testify#it('testify#assert#not_matches should not raise exception when arguments do not match',
      \ function('s:TestifyNotMatchesSuccess'))

function! s:TestifyNotMatchesFailure() abort
  call testify#assert#raise_exception(
        \ function('testify#assert#not_matches', ['match 1 2 3', '^match.*']),
        \ 'Expected "match 1 2 3" to not match regexp "^match.*"')
endfunction
call testify#it('testify#assert#not_matches should raise exception when arguments match',
      \ function('s:TestifyNotMatchesFailure'))

function! s:TestifyEmptySuccess() abort
  call testify#assert#not_raise_exception(
        \ function('testify#assert#empty', ['']))
endfunction
call testify#it('testify#assert#empty should not raise exception when argument is empty',
      \ function('s:TestifyEmptySuccess'))

function! s:TestifyEmptyFailure() abort
  call testify#assert#raise_exception(
        \ function('testify#assert#empty', ['match']),
        \ 'Expected "match" to be empty')
endfunction
call testify#it('testify#assert#empty should raise exception when arguments match',
      \ function('s:TestifyEmptyFailure'))

function! s:TestifyNotEmptySuccess() abort
  call testify#assert#not_raise_exception(
        \ function('testify#assert#not_empty', ['match']))
endfunction
call testify#it('testify#assert#not_empty should not raise exception when arguments is not empty',
      \ function('s:TestifyEmptyFailure'))

function! s:TestifyNotEmptyFailure() abort
  call testify#assert#raise_exception(
        \ function('testify#assert#not_empty', ['']),
        \ 'Expected "" to not be empty')
endfunction
call testify#it('testify#assert#not_empty should raise exception when argument is empty',
      \ function('s:TestifyNotEmptyFailure'))
