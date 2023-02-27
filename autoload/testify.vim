function! s:log_summary() abort
  let rantests = filter(copy(s:testifies), {_, t -> has_key(t, 'ran')})
  let testsrun = len(rantests)
  let fails = len(filter(copy(rantests), {_, t -> t.success == 0}))
  let msgs = []
  call add(msgs, 'Test Summary')
  call add(msgs, '------------')
  if fails == 0
    call add(msgs, 'All tests successful')
  endif
  call add(msgs, printf('Tests=%d', testsrun))
  if fails > 0
    call add(msgs, printf('Fails=%d', fails))
  endif
  call add(msgs, printf('Result: %s', fails == 0 ? 'PASS' : 'FAIL'))
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

function! testify#setup(func) abort
  let s:setup = a:func
endfunction

function! testify#teardown(func) abort
  let s:teardown = a:func
endfunction

function! s:run_test(test) abort
  try
    let result = a:test.func()
    call testify#logger#success(a:test.msg)
    let a:test.success = 1
  catch
    let g:testify_fail = 1
    let a:test.success = 0
    call testify#logger#fail(a:test.msg)
    call testify#logger#log("  " . v:exception)
    call testify#logger#throwpoint("    ")
  finally
    let a:test.ran = 1
  endtry
endfunction

function! s:run_report() abort
  call s:log_summary()
  call testify#logger#show()
endfunction

function! testify#run(index) abort
  if type(s:setup) == v:t_func && !empty(s:setup)
    call s:setup()
  endif
  call s:run_test(s:testifies[a:index])
  if type(s:teardown) == v:t_func && !empty(s:teardown)
    call s:teardown()
  endif
  call s:run_report()
endfunction

function! testify#run_all() abort
  if exists('s:setup') && type(s:setup) == v:t_func && !empty(s:setup)
    call s:setup()
  endif
  for test in s:testifies
    call s:run_test(test)
  endfor
  if exists('s:setup') && type(s:teardown) == v:t_func && !empty(s:teardown)
    call s:teardown()
  endif
  call s:run_report()
endfunction
