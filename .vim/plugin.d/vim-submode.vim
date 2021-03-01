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

call submode#enter_with('toggleCase', 'n', '', 'crl', ':<C-u>ConvertCaseLoop<CR>'   )
call submode#map('toggleCase', 'n', '', 'l', ':<C-u>ConvertCaseLoop<CR>')
