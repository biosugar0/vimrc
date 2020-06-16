" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" s{char}{char} to move to {char}{char}
map <leader>s <Plug>(easymotion-bd-f)
nmap <leader>s <Plug>(easymotion-overwin-f)
" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)
" ストローク選択を優先する
let g:EasyMotion_grouping=1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
