function! s:log_summary() abort
  let fails = len(filter(copy(s:testifies), 'v:val.success == 0'))
  let msgs = []
  call add(msgs, '* Test Summary')
  call add(msgs, '* ------------')
  if fails == 0
    call add(msgs, '* All tests successful')
  endif
  call add(msgs, printf('* Tests=%d', len(s:testifies)))
  if fails > 0
    call add(msgs, printf('* Fails=%d', fails))
  endif
  call add(msgs, printf('* Result: %s', fails == 0 ? 'PASS' : 'FAIL'))
  call testify#logger#info(msgs)
endfunction

let s:testifies = []
function! testify#it(msg, func) abort
  call add(s:testifies, {'msg': a:msg, 'func': a:func})
endfunction

function! testify#clear() abort
  let s:testifies = []
  call testify#logger#clear()
endfunction

function! testify#run() abort
  for test in s:testifies
    try
      let result = test.func()
      call testify#logger#success('√ ' . test.msg)
      let test.success = 1
    catch
      let g:testify_fail = 1
      let test.success = 0
      call testify#logger#fail('✗ ' . test.msg)
      call testify#logger#fail("\t" . v:exception)
      call testify#logger#throwpoint("\t\t")
    endtry
  endfor
  call s:log_summary()
  call testify#logger#show()
endfunction
