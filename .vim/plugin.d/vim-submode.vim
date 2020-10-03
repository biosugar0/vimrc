let g:submode_timeout=v:false
call submode#enter_with('blockmove', 'x', 'r', 'Mk', '<Plug>(textmanip-move-up)'   )
call submode#enter_with('blockmove', 'x', 'r', 'Mj', '<Plug>(textmanip-move-down)' )
call submode#enter_with('blockmove', 'x', 'r', 'Mh', '<Plug>(textmanip-move-left)' )
call submode#enter_with('blockmove', 'x', 'r', 'Ml', '<Plug>(textmanip-move-right)')
call submode#leave_with('blockmove', 'x', 'r', '<Esc>')
call submode#map('blockmove', 'x', 'r', 'k', '<Plug>(textmanip-move-up)'   )
call submode#map('blockmove', 'x', 'r', 'j', '<Plug>(textmanip-move-down)' )
call submode#map('blockmove', 'x', 'r', 'h', '<Plug>(textmanip-move-left)' )
call submode#map('blockmove', 'x', 'r', 'l', '<Plug>(textmanip-move-right)')
call submode#map('blockmove', 'x', 'r', 't', '<Plug>(textmanip-toggle-mode)')

" scroll down and enter chromectl mode.
call submode#enter_with('chromectl', 'n', 'r', '<leader>j', '<Plug>(ChromeDown)')
" scroll up and enter chromectl mode.
call submode#enter_with('chromectl', 'n', 'r', '<leader>k', '<Plug>(ChromeUp)')
" close current tab and enter chromectl mode.
call submode#enter_with('chromectl', 'n', 'r', '<leader>x', '<Plug>(ChromeTabClose)')
"

" in chromectl mode
" scroll down
call submode#map('chromectl', 'n', 'r', 'j', '<Plug>(ChromeDown)')
" scroll up
call submode#map('chromectl', 'n', 'r', 'k', '<Plug>(ChromeUp)')
" close current tab
call submode#map('chromectl', 'n', 'r', 'x', '<Plug>(ChromeTabClose)')
" Open a link in the current tab by Vimium
call submode#map('chromectl', 'n', 'r', 'i', ':<C-u>ChromeStroke "i"<CR>')
" Go one tab left by Vimium
call submode#map('chromectl', 'n', 'r', 'H', ':<C-u>ChromeStroke "H"<CR>')
" Go one tab right by Vimium
call submode#map('chromectl', 'n', 'r', 'L', ':<C-u>ChromeStroke "L"<CR>')
" Go forward in history by Vimium
call submode#map('chromectl', 'n', 'r', 'l', ':<C-u>ChromeStroke "l"<CR>')
" Go back in history by Vimium
call submode#map('chromectl', 'n', 'r', 'h', ':<C-u>ChromeStroke "h"<CR>')
" enter caret mode for Visual mode by Vimium
call submode#map('chromectl', 'n', 'r', 'c', ':<C-u>ChromeStroke "vc"<CR>')
" Visual mode by Vimium
call submode#map('chromectl', 'n', 'r', 'v', ':<C-u>ChromeStroke "v"<CR>')
" send Esc by Vimium
call submode#map('chromectl', 'n', 'r', 'E', ':<C-u>ChromeStrokeCode 53<CR>')
" send Enter by Vimium
call submode#map('chromectl', 'n', 'r', 'e', ':<C-u>ChromeStrokeCode 76<CR>')
