let g:mapleader = "\<space>"
let g:maplocalleader = "\<space>"
"jjをescに
inoremap <silent> jj <ESC>
tnoremap <silent> <ESC> <C-\><C-n>
" change window size
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
nnoremap <silent> <leader>vn :<C-u>setlocal number!<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>
nnoremap } :ls<CR>:b<Space>
 " Helpful delete/change into blackhole buffer
 nmap <leader>d "_d
 nmap <leader>c "_c
 " turn off highlight on enter twice
 nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
 nnoremap <silent><C-l><C-l> :<C-u>nohlsearch<CR>
