let g:testify#logger#output = 'buffer'

function! s:LogToBuffer(msg)
  let switchbufold = &switchbuf
  let bufnr = bufnr('testify_output', 1)
  set switchbuf=useopen
  exec 'sbuffer' bufnr
  setf testify
  setl previewwindow
  setl winheight=40 winfixheight
  setl buftype=nofile bufhidden=wipe nobuflisted
  call append(line('$')-1, a:msg)
  normal! gg
  wincmd p
  exec 'set switchbuf=' switchbufold
endfunction

function! testify#logger#success(msg)
  if g:testify#logger#output ==# 'echo'
    echohl Special | echo a:msg | echohl None
  elseif g:testify#logger#output ==# 'buffer'
    call s:LogToBuffer(a:msg)
  endif
endfunction

function! testify#logger#fail(msg)
  if g:testify#logger#output ==# 'echo'
    echohl Error | echo a:msg | echohl None
  elseif g:testify#logger#output ==# 'buffer'
    call s:LogToBuffer(a:msg)
  endif
endfunction
