set nrformats= "すべての数を10進数として扱う
set nrformats+=unsigned " 数字の増加減少でマイナスを扱わない
set virtualedit=all " allow virtual editing in all modes
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

"ファイル処理関連
set confirm  " 保存されていないファイルがあるときは終了前に保存確認
set hidden   " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread " 外部でファイルに変更がされた場合は読みなおす
set nrformats= "すべての数を10進数として扱う
set nrformats+=unsigned " 数字の増加減少でマイナスを扱わない
set isfname-== isfname+=32  " =をファイル名の一部と認識させない
set shell=zsh

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
set ttyfast

"タブ、インデント設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set mouse=""
