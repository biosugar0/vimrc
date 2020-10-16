" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" s{char}{char} to move to {char}{char}
map <leader>s <Plug>(easymotion-bd-f)
nmap <leader>s <Plug>(easymotion-overwin-f)
" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" ストローク選択を優先する
let g:EasyMotion_grouping=1
