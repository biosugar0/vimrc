let s:script = expand('<sfile>')


"hook function
function! s:ripgrep(hooktype, name)
    if executable('rg') == 0
        echom "ripgrep not found run 'brew install ripgrep'"
        echom system("brew install ripgrep")
    endif
endfunction

function! s:gtran(hooktype, name)
    if executable('gtran') == 0
        echom "gtran not found run 'go get github.com/skanehira/gtran'"
        echom system("go get github.com/skanehira/gtran")
    endif
endfunction


if exists('*minpac#init')
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    call minpac#add('prabirshrestha/async.vim')
    call minpac#add('prabirshrestha/asyncomplete.vim')
    call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('mattn/vim-lsp-settings')
    call minpac#add('mattn/vim-lsp-icons')
    call minpac#add('hrsh7th/vim-vsnip')
    call minpac#add('hrsh7th/vim-vsnip-integ')
    call minpac#add('mattn/vim-goimports')
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('mattn/vim-goaddtags')
    call minpac#add('machakann/vim-sandwich')
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('mattn/vim-findroot')
    call minpac#add('vim-jp/vimdoc-ja')
    call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
    call minpac#add('junegunn/fzf.vim',{'do': function('s:ripgrep') })
    call minpac#add('bkad/CamelCaseMotion')
    call minpac#add('easymotion/vim-easymotion')
    call minpac#add('terryma/vim-expand-region')
    call minpac#add('terryma/vim-multiple-cursors')
    call minpac#add('haya14busa/vim-asterisk')
    call minpac#add('tpope/vim-abolish')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('chriskempson/vim-tomorrow-theme')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('lambdalisue/gina.vim')
    call minpac#add('kana/vim-altr')
    call minpac#add('skanehira/translate.vim',{'do': function('s:gtran') })
    call minpac#add('vim-test/vim-test')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('biosugar0/vim-popyank')
endif
packloadall

" Load plugin.d/*.vim
function! s:load_configurations() abort
  for path in glob('$VIMHOME/plugin.d/*.vim', 1, 1, 1)
    execute printf('source %s', fnameescape(path))
  endfor
endfunction
call s:load_configurations()

if !exists('*s:init')
  function! s:init() abort
    packadd minpac
    execute 'source' fnameescape(s:script)
  endfunction
endif

command! PackUpdate call s:init() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call s:init() | call minpac#clean()
command! PackStatus call s:init() | call minpac#status()
