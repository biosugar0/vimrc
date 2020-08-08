nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#go#gotest#options = {
  \ 'nearest': '-v -count=1',
  \ 'file':    '-v -count=1',
  \ 'suite':   '-v -count=1',
\}

let g:test#strategy = 'dispatch'
