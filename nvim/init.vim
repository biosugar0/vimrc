let $VIMHOME = expand('<sfile>:p:h')

if has('vim_starting') " Vimの初期化プロセス中は真となる。
  if &compatible
    set nocompatible " Be iMproved
  endif

  set encoding=utf-8
  scriptencoding utf-8

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
	let g:did_install_default_menus   = 1
	let g:did_install_syntax_menu     = 1
	let g:loaded_2html_plugin         = 1
	let g:loaded_getscript            = 1
	let g:loaded_getscriptPlugin      = 1
	let g:loaded_gzip                 = 1
	let g:loaded_netrw                = 1
	let g:loaded_netrwFileHandlers    = 1
	let g:loaded_netrwPlugin          = 1
	let g:loaded_netrwSettings        = 1
	let g:loaded_rrhelper             = 1
	let g:loaded_tar                  = 1
	let g:loaded_tarPlugin            = 1
	let g:loaded_vimball              = 1
	let g:loaded_vimballPlugin        = 1
	let g:loaded_zip                  = 1
	let g:loaded_zipPlugin            = 1
	let g:no_gvimrc_example           = 1
	let g:no_vimrc_example            = 1
	let g:skip_loading_mswin          = 1

	set visualbell t_vb=    " 音もフラッシュも無効にする
    if exists('&belloff')
		set belloff=all " ベルを鳴らなさないようにする
	endif
  " キーを100ミリ秒以上待たない
	set timeout
	set ttimeout
  set ttimeoutlen=100
endif

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

set nrformats= "すべての数を10進数として扱う
set nrformats+=unsigned " 数字の増加減少でマイナスを扱わない
set virtualedit=all " allow virtual editing in all modes
"オートコメントアウト無効
au FileType * setlocal formatoptions-=ro

set clipboard=unnamed,unnamedplus " OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする

" 移動設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
set nostartofline              " 移動時にx軸をそのままにする

"保存時の設定
set undodir=~/.cache/nvim/undo
call mkdir(&undodir, 'p')
set undofile
set dir=~/.cache/nvim/swp
call mkdir(&dir, 'p')
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
autocmd FileType go,sql,python,vim,sh autocmd BufWritePre * :%s/\s\+$//ge
"強制全保存終了を無効化。
nnoremap ZZ <Nop>
nnoremap <C-d> <Nop>

"ファイル処理関連
set confirm  " 保存されていないファイルがあるときは終了前に保存確認
set hidden   " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread " 外部でファイルに変更がされた場合は読みなおす
set nrformats= "すべての数を10進数として扱う
set nrformats+=unsigned " 数字の増加減少でマイナスを扱わない
set isfname-== isfname+=32  " =をファイル名の一部と認識させない
set shell=zsh
"オートコメントアウト無効
au FileType * setlocal formatoptions-=ro

"検索設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る

"コマンドライン関連
set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=1000                        " コマンドラインの履歴を1000件保存する
" 表示設定
set termguicolors
set diffopt=vertical
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
set breakindent    " インデントされた行の折り返しを綺麗に
set cursorline  " カーソル行を強調
" 不可視文字の表示記号指定
set listchars=tab:\|-,trail:-,nbsp:%,eol:↲,extends:❯,precedes:❮
set foldmethod=marker
set ttyfast

"タブ、インデント設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set mouse=""

filetype plugin indent on

"ファイルをひらいたとき最後にカーソルがあった場所に移動
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" Load conf.d/*.vim
function! s:load_configurations() abort
  for path in glob('$VIMHOME/conf.d/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction
call s:load_configurations()

" プラグイン管理
source $VIMHOME/dein.vim
