function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  set completeopt=menuone,noinsert,noselect

  " mappings
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gr <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> == <plug>(lsp-document-format)
  nmap <buffer> <leader>n <plug>(lsp-next-error)
  nmap <buffer> <leader>p <plug>(lsp-previous-error)
  nmap <buffer> gD <plug>(lsp-references)
  nmap <buffer> gs <plug>(lsp-document-symbol)
  nmap <buffer> gS <plug>(lsp-workspace-symbol)
  vmap <buffer> = <plug>(lsp-document-range-format)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> K <Plug>(lsp-hover)
  inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

  " on save
  autocmd BufWritePre *.go LspDocumentFormatSync

  " commands
  command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')
endfunction

" lsp config
let g:lsp_diagnostics_enabled = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_matchfuzzy = 1
let g:asyncomplete_min_chars = 2
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 10
let g:lsp_insert_text_enabled = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 100
let g:lsp_highlight_reference_enabled = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']
let g:lsp_settings = {
\'gopls':{
  \'workspace_config': {
    \'staticcheck': v:true,
    \'completeUnimported': v:true,
    \'caseSensitiveCompletion': v:true,
    \'usePlaceholders': v:true,
    \'completionDocumentation': v:true,
    \'watchFileChanges': v:true,
    \'hoverKind': 'SingleLine',
    \'analyses': {
        \'nonewvars': v:true,
        \'unusedparams': v:true
    \},
  \},
  \'initialization_options': {
    \ 'usePlaceholders': v:true,
    \ "completeUnimported": v:true,
    \ "staticcheck": v:true,
    \ 'analyses': {
        \ 'nonewvars': v:true,
        \ 'unusedparams': v:true
      \ },
  \ },
\},
\'golangci-lint-langserver':{
  \'initialization_options': {
      \'command': ['golangci-lint', 'run', '--enable-all',
        \'--disable', 'lll', '--disable','gochecknoglobals',
        \'--out-format', 'json']
  \},
\},
\}

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
