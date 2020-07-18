nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#go#gotest#options = {
  \ 'nearest': '-v',
  \ 'file':    '-v',
  \ 'suite':   '-v',
\}

let g:test#strategy = 'dispatch'
