function! vimrc#on_filetype() abort
  if execute('filetype') !~# 'OFF'
    if !exists('b:did_ftplugin')
      runtime! after/ftplugin.vim
    endif

    return
  endif

  filetype plugin indent on
  syntax enable

  " Note: filetype detect does not work on startup
  filetype detect
endfunction

function! vimrc#enable_syntax() abort
  syntax enable

  if has('nvim') && exists(':TSEnableAll')
    TSBufEnable highlight
    TSBufEnable context_commentstring
  endif
endfunction
function! vimrc#disable_syntax() abort
  if &l:syntax !=# ''
    syntax off
  endif

  if has('nvim') && exists(':TSEnableAll')
    TSBufDisable highlight
    TSBufDisable context_commentstring
  endif
endfunction
