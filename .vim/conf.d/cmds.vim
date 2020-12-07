function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

function! s:www(word) abort
  execute('term ++close ++shell w3m google.com/search\?q="' . a:word . '"')
endfunction

function! s:gg(package) abort
  execute('term ++close ++shell w3m pkg.go.dev/' . a:package)
endfunction

command! -nargs=1 WWW call s:www(<f-args>)
command! -nargs=1 GG call s:gg(<f-args>)

if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
endif

augroup AutoQuickfix
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

function! s:termopen() abort
    let name = split(bufname(), '\/\/')
    if len(name) < 2
        return
    endif
    call execute(printf('term ++curwin ++close ++shell %s', name[1]))
endfunction

augroup terminal
  au!
  au BufReadCmd term://* call s:termopen()
augroup END

" auto reload Vim setting
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vim,*vimrc source $MYVIMRC | set foldmethod=marker
augroup END
