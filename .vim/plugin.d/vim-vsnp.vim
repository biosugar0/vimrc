imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <C-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-k>'
