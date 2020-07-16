function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gr <plug>(lsp-rename)
  nmap <buffer> gn <plug>(lsp-next-diagnostic)
  nmap <buffer> == <plug>(lsp-document-format)
  nmap <buffer> <leader>n <plug>(lsp-next-error)
  nmap <buffer> <leader>p <plug>(lsp-previous-error)
  nmap <buffer> gD <plug>(lsp-references)
  nmap <buffer> gs <plug>(lsp-document-symbol)
  nmap <buffer> gS <plug>(lsp-workspace-symbol)
  vmap <buffer> = <plug>(lsp-document-range-format)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> K <Plug>(lsp-hover)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')
autocmd BufWritePre <buffer> LspDocumentFormatSync
let g:lsp_diagnostics_enabled = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 180
let g:lsp_insert_text_enabled = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']
let g:lsp_settings = {
            \ 'workspace_config': {'gopls': {
            \ 'staticcheck': v:true,
            \ 'completeUnimported': v:true,
            \ 'caseSensitiveCompletion': v:true,
            \ 'usePlaceholders': v:true,
            \ 'completionDocumentation': v:true,
            \ 'watchFileChanges': v:true,
            \ 'hoverKind': 'SingleLine',
            \   }},
            \}
