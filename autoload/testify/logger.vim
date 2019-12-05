let g:testify#logger#output = 'buffer'

let s:logs = []

function! s:LogToEcho(log)
  if a:log.type ==# 'success'
    silent! exec '!echo' a:log.msg
  elseif a:log.type ==# 'fail'
    silent! exec '!echo' a:log.msg
  elseif a:log.type ==# 'info'
    silent! exec '!echo' a:log.msg
  endif
endfunction

let s:buffer_name = 'testify_output'
function! s:ClearBuffer()
  let bufnr = bufnr(s:buffer_name, 1)
  exec 'sbuffer' bufnr
  :%delete
  quit
endfunction

function! s:LogToBuffer(log)
  let switchbufold = &switchbuf
  let bufnr = bufnr(s:buffer_name, 1)
  set switchbuf=useopen
  exec 'sbuffer' bufnr
  setf testify
  setl previewwindow
  setl winheight=40 winfixheight
  setl buftype=nofile bufhidden=wipe nobuflisted
  call append(line('$')-1, a:log.msg)
  normal! gg
  wincmd p
  exec 'set switchbuf=' switchbufold
endfunction

function! s:log(type, msg)
  call add(s:logs, {'type': a:type, 'msg': a:msg})
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
  let stack_with_lines = map(stack, {_, s -> substitute(s, '\[\(\d\+\)\]', ' line \1', 'g')})
  let msg = map(stack_with_lines[1:-3], {_, s -> a:prefix . s})
  call s:log('fail', msg)
endfunction

function! testify#logger#show()
  if has('vim_starting')
    let g:testify#logger#output = 'echo'
  endif

  if g:testify#logger#output ==# 'buffer'
    call s:ClearBuffer()
  endif

  for log in s:logs
    if g:testify#logger#output ==# 'echo'
      call s:LogToEcho(log)
    elseif g:testify#logger#output ==# 'buffer'
      call s:LogToBuffer(log)
    endif
  endfor
endfunction

function! testify#logger#clear()
  let s:logs = []
endfunction
