"強制全保存終了を無効化。
nnoremap ZZ <Nop>
nnoremap <C-d> <Nop>
"jjをescに
inoremap <silent> jj <ESC>
tnoremap <silent> <ESC> <C-\><C-n>
cnoremap <expr> j
      \ getcmdline()[getcmdpos()-2] ==# 'j' ? '<BS><C-c>' : 'j'

inoremap /c <C-R>=expand('%:p')<CR>

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
xnoremap <leader>d "_d
xnoremap <leader>c "_c
 " turn off highlight on enter twice
nnoremap <silent><Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <silent><C-l><C-l> :<C-u>nohlsearch<CR>
nnoremap qt  :<C-u>tabclose<CR>
nnoremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'
cabbr w!! w !sudo tee > /dev/null % " w!!でsudoで保存
