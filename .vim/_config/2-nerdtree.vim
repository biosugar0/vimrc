autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeShowHidden=1
nnoremap <silent><C-e> :NERDTreeToggle<CR>
