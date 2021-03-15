let s:script = expand('<sfile>')

"hook function{{{
function! s:ripgrep(hooktype, name)
    if executable('rg') == 0
        echom "ripgrep not found run 'brew install ripgrep'"
        echom system("brew install ripgrep")
    endif
endfunction
"}}}
function! PackInit() abort
    if !exists('g:loaded_minpac')
        packadd minpac
        call minpac#init({'progress_open': 'none'})
        call minpac#add('k-takata/minpac', {'type': 'opt'})
        " PLUGINS{{{
        call minpac#add('AndrewRadev/linediff.vim')
        call minpac#add('LeafCage/yankround.vim')
        call minpac#add('airblade/vim-gitgutter')
        call minpac#add('biosugar0/vim-popyank')
        call minpac#add('chriskempson/vim-tomorrow-theme')
        call minpac#add('christoomey/vim-tmux-navigator')
        call minpac#add('cohama/lexima.vim')
        call minpac#add('easymotion/vim-easymotion')
        call minpac#add('glidenote/memolist.vim')
        call minpac#add('haya14busa/vim-asterisk')
        call minpac#add('haya14busa/vim-edgemotion')
        call minpac#add('hrsh7th/vim-eft')
        call minpac#add('hrsh7th/vim-vsnip')
        call minpac#add('hrsh7th/vim-vsnip-integ')
        call minpac#add('junegunn/fzf', {'do': {-> system('./install --all')}})
        call minpac#add('junegunn/fzf.vim',{'do': function('s:ripgrep') })
        call minpac#add('junegunn/vim-easy-align')
        call minpac#add('kana/vim-altr')
        call minpac#add('kana/vim-operator-replace')
        call minpac#add('kana/vim-operator-user')
        call minpac#add('kana/vim-textobj-user')
        call minpac#add('lambdalisue/fern-renderer-nerdfont.vim')
        call minpac#add('lambdalisue/fern.vim')
        call minpac#add('lambdalisue/gina.vim')
        call minpac#add('lambdalisue/nerdfont.vim')
        call minpac#add('machakann/vim-sandwich')
        call minpac#add('machakann/vim-textobj-delimited')
        call minpac#add('mattn/vim-findroot')
        call minpac#add('mattn/vim-goaddtags')
        call minpac#add('mattn/vim-goimports')
        call minpac#add('mattn/vim-lsp-icons')
        call minpac#add('mattn/vim-lsp-settings')
        call minpac#add('mattn/vim-maketable')
        call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
        call minpac#add('prabirshrestha/asyncomplete.vim')
        call minpac#add('prabirshrestha/vim-lsp')
        call minpac#add('previm/previm')
        call minpac#add('rhysd/conflict-marker.vim')
        call minpac#add('sgur/vim-textobj-parameter')
        call minpac#add('sheerun/vim-polyglot')
        call minpac#add('skanehira/gh.vim')
        call minpac#add('skanehira/translate.vim')
        call minpac#add('t9md/vim-textmanip')
        call minpac#add('thinca/vim-qfreplace')
        call minpac#add('mopp/vim-operator-convert-case')
        call minpac#add('tpope/vim-dispatch')
        call minpac#add('tpope/vim-repeat')
        call minpac#add('vim-airline/vim-airline')
        call minpac#add('vim-airline/vim-airline-themes')
        call minpac#add('vim-jp/vimdoc-ja')
        call minpac#add('vim-test/vim-test')
        "}}}
        packloadall
  endif
endfunction
call PackInit()

command! PackInstall call PackInit() | call minpac#update('',{'do': 'let g:plugin_installed = 1'})
command! PackUpdate  call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean   call PackInit() | call minpac#clean()
command! PackStatus  call PackInit() | call minpac#status()
