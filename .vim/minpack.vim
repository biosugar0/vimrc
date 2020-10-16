let s:script = expand('<sfile>')

if !exists('g:loaded_minpac')
    "hook function{{{
    function! s:ripgrep(hooktype, name)
        if executable('rg') == 0
            echom "ripgrep not found run 'brew install ripgrep'"
            echom system("brew install ripgrep")
        endif
    endfunction
"}}}
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    " PLUGINS{{{
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('biosugar0/chrome.vim')
    call minpac#add('biosugar0/vim-popyank')
    call minpac#add('bkad/CamelCaseMotion')
    call minpac#add('chriskempson/vim-tomorrow-theme')
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('cohama/lexima.vim')
    call minpac#add('easymotion/vim-easymotion')
    call minpac#add('haya14busa/vim-asterisk')
    call minpac#add('hrsh7th/vim-eft')
    call minpac#add('hrsh7th/vim-vsnip')
    call minpac#add('hrsh7th/vim-vsnip-integ')
    call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
    call minpac#add('junegunn/fzf.vim',{'do': function('s:ripgrep') })
    call minpac#add('junegunn/vim-easy-align')
    call minpac#add('kana/vim-altr')
    call minpac#add('kana/vim-operator-replace')
    call minpac#add('kana/vim-operator-user')
    call minpac#add('kana/vim-submode')
    call minpac#add('lambdalisue/fern-renderer-nerdfont.vim')
    call minpac#add('lambdalisue/fern.vim')
    call minpac#add('lambdalisue/gina.vim')
    call minpac#add('lambdalisue/nerdfont.vim')
    call minpac#add('machakann/vim-sandwich')
    call minpac#add('mattn/vim-findroot')
    call minpac#add('mattn/vim-goaddtags')
    call minpac#add('mattn/vim-goimports')
    call minpac#add('mattn/vim-lsp-icons')
    call minpac#add('mattn/vim-lsp-settings')
    call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
    call minpac#add('prabirshrestha/asyncomplete.vim')
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('previm/previm')
    call minpac#add('rhysd/conflict-marker.vim')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('skanehira/translate.vim')
    call minpac#add('t9md/vim-textmanip')
    call minpac#add('terryma/vim-expand-region')
    call minpac#add('terryma/vim-multiple-cursors')
    call minpac#add('thinca/vim-qfreplace')
    call minpac#add('tpope/vim-abolish')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')
    call minpac#add('vim-jp/vimdoc-ja')
    call minpac#add('vim-test/vim-test')
"}}}
endif

packloadall

" Load plugin.d/*.vim{{{
function! s:load_configurations() abort
  for path in glob('$VIMHOME/plugin.d/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction
call s:load_configurations()
"}}}

if !exists('*s:init')
  function! s:init() abort
    execute 'source' fnameescape(s:script)
  endfunction
endif

command! PackUpdate call s:init() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call s:init() | call minpac#clean()
command! PackStatus call s:init() | call minpac#status()
