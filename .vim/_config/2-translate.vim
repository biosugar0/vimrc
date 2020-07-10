let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_winsize = 10
xmap <Space>tr <Plug>(VTranslate)
xmap <Space>tr <Plug>(VTranslateBang)
function! s:gg(package) abort
  execute('term ++close ++shell w3m pkg.go.dev/' . a:package)
endfunction

command! -nargs=1 GG call s:gg(<f-args>)
