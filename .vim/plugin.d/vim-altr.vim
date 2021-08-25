function! s:makegotest() abort
  let src=expand("%:p:r")
  let filex=expand("%:p:e")
  if filex != "go"
      return
  endif
  if expand("%:p:r") !~ "test$"
      let src.="_test"
  endif
  let src.=".go"
  let chk=getftype(src)
  if chk == "file" 
      return
  endif
  call writefile(["package"],src)
endfunction

nnoremap <SID>(makegotest) <Cmd>call <SID>makegotest()<CR>
nmap <leader>t <SID>(makegotest)<Plug>(altr-forward)
