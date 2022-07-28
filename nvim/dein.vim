let $VIMHOME = expand('<sfile>:p:h')
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:rc_dir = $VIMHOME

" dein.vimがインストールされていなかったらインストール
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  if filereadable(expand(s:toml))
    call dein#load_toml(s:toml, {'lazy': 0})
  endif

  if filereadable(expand(s:lazy_toml))
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
  endif

  call dein#end()
  call dein#save_state()
endif

function! DeinInstall() abort
  if dein#check_install()
    call dein#install()
  endif
endfunction

function! DeinClean() abort
  let s:removed_plugins = dein#check_clean()
  if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
  endif
endfunction

command! DeinInstall call DeinInstall()
command! DeinClean call DeinClean()
