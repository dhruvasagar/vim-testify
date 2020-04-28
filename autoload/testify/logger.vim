let g:testify#logger#type = 'buffer'

let s:logs = []

function! s:log(type, msg) abort
  call add(s:logs, {'type': a:type, 'msg': a:msg})
endfunction

function! s:get_clear_fn() abort
  return function('testify#logger#'.g:testify#logger#type.'#clear')
endfunction

function! s:get_log_fn() abort
  return function('testify#logger#'.g:testify#logger#type.'#log')
endfunction

function! testify#logger#info(msg)
  call s:log('info', a:msg)
endfunction

function! testify#logger#success(msg)
  call s:log('success', a:msg)
endfunction

function! testify#logger#fail(msg)
  call s:log('fail', a:msg)
endfunction

function! testify#logger#throwpoint(prefix)
  let tp = v:throwpoint
  let stack = split(tp, '\.\.')
  let stack_with_lines = map(stack, {_, s -> substitute(s, '\[\(\d\+\)\]', ':\1', 'g')})
  if !exists('g:testify#logger#debug')
    let index = -1
    while index < len(stack_with_lines)
      let index += 1
      if stack_with_lines[index] =~# '_run_test:2' | break | endif
    endwhile
    let index += 1
    let stack_with_lines = stack_with_lines[index:-3]
  endif
  let msg = map(stack_with_lines, {_, s -> a:prefix . s})
  call s:log('fail', msg)
endfunction

function! testify#logger#show()
  if has('vim_starting')
    let g:testify#logger#type = 'shell'
  endif

  let CleanFn = s:get_clear_fn()
  call CleanFn()

  for log in s:logs
    let LogFn = s:get_log_fn()
    call LogFn(log)
  endfor
endfunction

function! testify#logger#clear()
  let s:logs = []
endfunction
