"f/t/F/T を単語境界のみにマッチさせる機能を持ったプラグイン
if !exists('g:loaded_eft')
  finish
endif

nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)

nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)

nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)

let g:eft_repeatable = v:true

let g:eft_ignorecase = v:true
