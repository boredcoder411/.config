function! s:RunMakeInPanel()
  " Create a new vertical split and run make inside it
  vnew
  terminal make
  " Switch to the terminal buffer
  wincmd l
  wincmd h
  " Set to terminal mode
  startinsert
endfunction

command! MakePanel call s:RunMakeInPanel()
