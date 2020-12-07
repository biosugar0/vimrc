nnoremap <silent> <Leader>d :<C-u>Linediff<CR>
let g:linediff_first_buffer_command  = 'leftabove new'
let g:linediff_second_buffer_command = 'rightbelow vertical new'
autocmd User LinediffBufferReady nnoremap <buffer> <silent> q :<C-u>LinediffReset<CR>
