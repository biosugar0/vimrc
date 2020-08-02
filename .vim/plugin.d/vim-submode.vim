let g:submode_timeout=v:false
call submode#enter_with('chromectl', 'n', 'r', '<leader>j', '<Plug>(ChromeDown)')
call submode#enter_with('chromectl', 'n', 'r', '<leader>k', '<Plug>(ChromeUp)')
call submode#enter_with('chromectl', 'n', 'r', '<leader>x', '<Plug>(ChromeTabClose)')
call submode#map('chromectl', 'n', 'r', 'j', '<Plug>(ChromeDown)')
call submode#map('chromectl', 'n', 'r', 'k', '<Plug>(ChromeUp)')
call submode#map('chromectl', 'n', 'r', 'x', '<Plug>(ChromeTabClose)')
call submode#map('chromectl', 'n', 'r', 'i', ':<C-u>ChromeStroke "i"<CR>')
call submode#map('chromectl', 'n', 'r', 'H', ':<C-u>ChromeStroke "H"<CR>')
call submode#map('chromectl', 'n', 'r', 'L', ':<C-u>ChromeStroke "L"<CR>')
call submode#map('chromectl', 'n', 'r', 'l', ':<C-u>ChromeStroke "l"<CR>')
call submode#map('chromectl', 'n', 'r', 'h', ':<C-u>ChromeStroke "h"<CR>')
call submode#map('chromectl', 'n', 'r', 'c', ':<C-u>ChromeStroke "vc"<CR>')
call submode#map('chromectl', 'n', 'r', 'v', ':<C-u>ChromeStroke "v"<CR>')
" Esc
call submode#map('chromectl', 'n', 'r', 'E', ':<C-u>ChromeStrokeCode 53<CR>')
"Enter
call submode#map('chromectl', 'n', 'r', 'e', ':<C-u>ChromeStrokeCode 76<CR>')
