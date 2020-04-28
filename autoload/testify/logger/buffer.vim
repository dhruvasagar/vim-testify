let s:buffer_name = 'testify_output'
function! testify#logger#buffer#clear()
  let bufnr = bufnr(s:buffer_name, 1)
  exec 'sbuffer' bufnr
  :%delete
  quit
endfunction

function! testify#logger#buffer#log(log)
  let switchbufold = &switchbuf
  let bufnr = bufnr(s:buffer_name, 1)
  set switchbuf=useopen
  exec 'sbuffer' bufnr
  setf testify
  setl previewwindow
  setl previewheight=40 winfixheight
  setl buftype=nofile bufhidden=wipe nobuflisted
  call append(line('$')-1, a:log.msg)
  normal! gg
  wincmd p
  exec 'set switchbuf=' switchbufold
endfunction
