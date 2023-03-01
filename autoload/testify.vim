function! s:log_summary() abort
  let tests = flatten(map(values(s:testifies), {_, t -> t.tests}))
  let rantests = filter(tests, {_, t -> has_key(t, 'ran')})
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

function! s:get_context() abort
  let stack = expand('<sfile>')
  let stack_lines = split(stack, '\.\.')
  let b:stack = stack_lines
  let ctx = substitute(stack_lines[len(stack_lines)-3], 'script \(.\{-}\)\[\d\+\]', '\1', '')
  if !has_key(s:testifies, ctx)
    let s:testifies[ctx] = {'tests': []}
  endif
  return ctx
endfunction

let s:testifies = {}
function! testify#it(msg, func) abort
  let ctx = s:get_context()
  " echom ctx
  call add(s:testifies[ctx].tests, {'msg': a:msg, 'func': a:func})
endfunction

function! testify#clear() abort
  let s:testifies = {}
  call testify#logger#clear()
endfunction

function! testify#setup(func) abort
  let ctx = s:get_context()
  " echom ctx
  let s:testifies[ctx].setup = a:func
endfunction

function! testify#teardown(func) abort
  let ctx = s:get_context()
  " echom ctx
  let s:testifies[ctx].teardown = a:func
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

function! testify#run(ctx, index) abort
  if has_key(s:testifies[a:ctx], 'setup')
    call s:testifies[a:ctx].setup()
  endif
  call s:run_test(s:testifies[a:ctx].tests[a:index])
  call testify#logger#log('')
  if has_key(s:testifies[a:ctx], 'teardown')
    call s:testifies[a:ctx].teardown()
  endif
  call s:run_report()
endfunction

function! testify#run_all() abort
  for [ctx, filetest] in items(s:testifies)
    if has_key(s:testifies[ctx], 'setup')
      call s:testifies[ctx].setup()
    endif

    call testify#logger#info(fnamemodify(ctx, ':.'))
    for test in filetest.tests
      call s:run_test(test)
    endfor
    call testify#logger#log('')

    if has_key(s:testifies[ctx], 'teardown')
      call s:testifies[ctx].teardown()
    endif
  endfor
  call s:run_report()
endfunction

function! testify#inspect()
  return s:testifies
endfunction
