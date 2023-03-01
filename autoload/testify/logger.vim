let g:testify#logger#type = 'buffer'

let s:logs = []

function! s:log(type, msg) abort
  let l:prefix = ''
  if a:type ==# 'info'
    let l:prefix = '*'
  elseif a:type ==# 'success'
    let l:prefix = '√'
  elseif a:type ==# 'fail'
    let l:prefix = '✗'
  endif
  let l:msg = ''
  if !empty(a:msg)
    if type(a:msg) ==# v:t_string
      let l:msg = l:prefix . ' ' . a:msg
    elseif type(a:msg) ==# v:t_list
      let l:msg = map(a:msg, {_, m -> l:prefix . ' ' . m})
    endif
  endif
  call add(s:logs, {'type': a:type, 'msg': l:msg})
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

function! testify#logger#log(msg)
  call s:log('noprefix', a:msg)
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
  call s:log('noprefix', msg)
endfunction

function! testify#logger#show()
  if has('vim_starting')
    let g:testify#logger#type = 'echo'
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
