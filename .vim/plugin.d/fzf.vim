let g:fzf_layout = { 'down': '40%' }
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>F :Files?<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>gF :GFiles?<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>m :Mark<CR>
nnoremap <silent> <leader>R :Rg<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-g>

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --line-number --no-heading '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:wrap'))

inoremap <expr> <c-f><c-i> fzf#vim#complete('gopkgs -format "{{.ImportPath}}"')
