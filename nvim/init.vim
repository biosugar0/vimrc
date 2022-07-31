let $VIMHOME = expand('<sfile>:p:h')

if &compatible
  set nocompatible " Be iMproved
endif

if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf-8

  let g:mapleader = "\<space>"
  let g:maplocalleader = "\<space>"

  if !has('gui_running')
        \ && exists('&termguicolors')
        \ && $COLORTERM =~# '^\%(truecolor\|24bit\)$'
    " https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
    if !has('nvim')
      let &t_8f = "\e[38;2;%lu;%lu;%lum"
      let &t_8b = "\e[48;2;%lu;%lu;%lum"
    endif
    set termguicolors       " use truecolor in term

    if exists('&pumblend')
      set pumblend=20
    endif
  endif
  " 必要ないデフォルトプラグインを読み込まない
  let g:did_install_default_menus = 1
  let g:did_install_syntax_menu   = 1
  let g:loaded_2html_plugin       = 1
  let g:loaded_getscript          = 1
  let g:loaded_getscriptPlugin    = 1
  let g:loaded_gzip               = 1
  let g:loaded_netrw              = 1
  let g:loaded_netrwFileHandlers  = 1
  let g:loaded_netrwPlugin        = 1
  let g:loaded_netrwSettings      = 1
  let g:loaded_rrhelper           = 1
  let g:loaded_tar                = 1
  let g:loaded_tarPlugin          = 1
  let g:loaded_vimball            = 1
  let g:loaded_vimballPlugin      = 1
  let g:loaded_zipPlugin          = 1
  let g:loaded_zip                = 1
  let g:no_gvimrc_example         = 1
  let g:no_vimrc_example          = 1
  let g:skip_loading_mswin        = 1
  let g:loaded_man                = 1
  let g:loaded_tutor_mode_plugin  = 1

  set visualbell t_vb=    " 音もフラッシュも無効にする
  if exists('&belloff')
    set belloff=all " ベルを鳴らなさないようにする
  endif
  " キーを100ミリ秒以上待たない
  set timeout
  set ttimeout
  set ttimeoutlen=100
endif

"強制全保存終了を無効化。
nnoremap ZZ <Nop>
nnoremap <C-d> <Nop>

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

" dein options
let g:dein#lazy_rplugins = v:true

if dein#load_state(s:dein_dir)
  let g:dein#inline_vimrcs = glob('$VIMHOME/conf.d/*.vim', 1, 1, 1)
  map(g:dein#inline_vimrcs , {path ->  fnameescape(path)})

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
command! DeinReCache call dein#recache_runtimepath()
