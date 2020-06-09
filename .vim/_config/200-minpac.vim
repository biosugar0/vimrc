"hook function
function! s:ripgrep(hooktype, name)
    if executable('rg') == 0
        echom "ripgrep not found run 'brew install ripgrep'"
        echom system("brew install ripgrep")
    endif
endfunction

call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/asyncomplete.vim')
call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('mattn/vim-lsp-settings')
call minpac#add('mattn/vim-lsp-icons')
call minpac#add('hrsh7th/vim-vsnip')
call minpac#add('hrsh7th/vim-vsnip-integ')
call minpac#add('mattn/vim-goimports')
call minpac#add('tpope/vim-fugitive')
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
call minpac#add('wellle/context.vim')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('chriskempson/vim-tomorrow-theme')
call minpac#add('tpope/vim-unimpaired')
