augroup indentConf
  au!
  au FileType js   setlocal sw=2 sts=2 ts=2 et
  au FileType vue  setlocal sw=2 sts=2 ts=2 et
  au FileType vim  setlocal sw=2 sts=2 ts=2 et
  au FileType yaml setlocal ts=2 sts=2 sw=2 et
augroup END


augroup vimrc-auto-createfile
  autocmd!
  autocmd BufRead,BufNewFile $MEMO_DIRECTORY* setlocal path+=$MEMO_DIRECTORY/**
  set suffixesadd+=.md
  nnoremap <silent> gf :call <sid>open_file_or_create_new()<CR>

  function! s:open_file_or_create_new() abort
    let l:path = expand('<cfile>')
    if empty(l:path)
      return
    endif

    try
      exe 'norm!gf'
    catch /.*/
      echo 'New file.'
      let l:new_path = fnamemodify(expand('%:p:h') . '/' . l:path, ':p')
      if !empty(fnamemodify(l:new_path, ':e')) "Edit immediately if file has extension
        return execute('edit '.l:new_path)
      endif

      let l:suffixes = split(&suffixesadd, ',')

      for l:suffix in l:suffixes
        if filereadable(l:new_path.l:suffix)
          return execute('edit '.l:new_path.l:suffix)
        endif
      endfor

      return execute('edit '.l:new_path.l:suffixes[0])
    endtry
  endfunction
augroup END

" 保存時に存在しないディレクトリを作成
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

" 末尾の空白削除
augroup trim-space
    autocmd!
    autocmd FileType go,sql,python,vim,sh autocmd BufWritePre * :%s/\s\+$//ge
augroup END

"オートコメントアウト無効
augroup disableCommentout
  autocmd!
  au FileType * setlocal formatoptions-=ro
augroup END

"ファイルをひらいたとき最後にカーソルがあった場所に移動
augroup restore-cursor
  autocmd!
  autocmd BufReadPost *
        \ : if line("'\"") >= 1 && line("'\"") <= line("$")
        \ |   exe "normal! g`\""
        \ | endif
  autocmd BufWinEnter *
        \ : if empty(&buftype) && line('.') > winheight(0) / 3 * 2
        \ |   execute 'normal! zz' .. repeat("\<C-y>", winheight(0) / 6)
        \ | endif
augroup END
