if !exists('g:loaded_pyank') || has('nvim')
  finish
endif

nmap <leader>y <Plug>(PopYank)

" dependency translate.vim {{
nunmap <leader>y

function! s:Ptranslate()
    call popyank#exec()
    let pop = popyank#pop()
    if len(pop) == 0
        echom "no popup window"
    endif
    exec 'Translate'. " ".pop
endfunction

command! -nargs=0 Ptranslate call s:Ptranslate()
nmap <leader>y :<C-u>Ptranslate<CR>
"}}
