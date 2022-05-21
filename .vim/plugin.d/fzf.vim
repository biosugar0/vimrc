" fzf settings
let $FZF_DEFAULT_OPTS="--layout=reverse"
let $FZF_DEFAULT_COMMAND="rg --line-number --no-heading --files --hidden --glob '!.git/**'"

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
nnoremap <silent> <leader>f :Files<CR>
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

let g:fzf_action = {
                \'ctrl-t':'tab split',
                \'ctrl-s':'split',
                \'ctrl-e':'edit',
                \'enter':'vsplit'
                \}
let &grepprg = 'rg --json $* \| jq -r ''select(.type=="match")\|.data as $data\|$data.submatches[]\|"\($data.path.text):\($data.line_number):\(.start+1):\(.end+1):\($data.lines.text//""\|sub("\n$";""))"'''
set grepformat=%f:%l:%c:%k:%m
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --line-number --no-heading '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:wrap'))

inoremap <expr> <c-f><c-i> fzf#vim#complete('gopkgs -format "{{.ImportPath}}"')

let g:helppaths = uniq(sort(split(globpath(&runtimepath, 'doc/**', 1), '\n')))
command! -bang -nargs=* HelpRg
      \ call fzf#vim#grep(
      \   'rg --line-number --no-heading -g "*" "" '. join(g:helppaths).shellescape(<q-args>), 1,
      \   fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:90%'), <bang>0)
