" fzf settings
let $FZF_PREVIEW_PLUGIN_HELP_ROOT_DIR = $HOME.'/.vim/pack/minpac/start'
let g:fzf_preview_default_fzf_options = {
\ '--reverse': v:true,
\ '--preview-window': 'wrap',
\ '--exact': v:true,
\ '--no-sort': v:true,
\ }
let g:fzf_preview_mru_limit = 500
let g:fzf_preview_grep_cmd  = 'rg --line-number --no-heading --color=always --sort=path'

nnoremap <silent> <leader>h :<C-u>FzfPreviewGrepHelpRpc <Space>
nnoremap <silent> <leader>R :<C-u>FzfPreviewProjectGrepRpc --experimental-fast --add-fzf-arg=--exact --add-fzf-arg=--no-sort --add-fzf-arg=--nth=3 .<CR>
xnoremap n "sy:FzfPreviewProjectGrepRpc --experimental-fast --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"<CR>

nnoremap <silent> <leader>f :<C-u>FzfPreviewProjectFilesRpc<CR>
nnoremap <silent> <leader>gf :<C-u>FzfPreviewFromResourcesRpc project_mru git<CR>
nnoremap <silent> <leader>b :<C-u>FzfPreviewBuffersRpc<CR>
nnoremap <silent> <leader>m :<C-u>FzfPreviewMarksRpc<CR>
nnoremap <silent> <leader>o :<C-u>FzfPreviewFromResourcesRpc buffer project_mru<CR>
nnoremap <silent> <leader><C-o> :<C-u>FzfPreviewJumpsRpc<CR>
nnoremap <silent> <leader>/     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> <leader>*     :<C-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
