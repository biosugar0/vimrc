if !exists('g:loaded_gina')
  finish
endif

let g:gina#command#blame#formatter#format ="%au%=on %ti %ma%in"


nnoremap <silent> <Leader>aa :<C-u>Gina status<CR>
nnoremap <silent> <Leader>aA :<C-u>Gina changes HEAD<CR>
nnoremap <silent> <Leader>ac :<C-u>Gina commit<CR>
nnoremap <silent> <Leader>aC :<C-u>Gina commit --amend<CR>
nnoremap <silent> <Leader>ab :<C-u>Gina branch -av<CR>
nnoremap <silent> <Leader>at :<C-u>Gina tag<CR>
nnoremap <silent> <Leader>ag :<C-u>Gina grep<CR>
nnoremap <silent> <Leader>aq :<C-u>Gina qrep<CR>
nnoremap <silent> <Leader>ap :<C-u>Gina push<CR>
nnoremap <silent> <Leader>ad :<C-u>Gina changes origin/HEAD...<CR>
nnoremap <silent> <Leader>ah :<C-u>Gina log --graph<CR>
nnoremap <silent> <Leader>aH :<C-u>Gina log --graph --all<CR>
nnoremap <silent> <Leader>al :<C-u>Gina log<CR>
nnoremap <silent> <Leader>aL :<C-u>Gina log :%<CR>
nnoremap <silent> <Leader>af :<C-u>Gina ls<CR>
nnoremap <silent> <Leader>ars :<C-u>Gina show <C-r><C-w><CR>
nnoremap <silent> <Leader>arc :<C-u>Gina changes <C-r><C-w><CR>
nnoremap <silent> <Leader>ao :Gina browse --extract :<CR>
xnoremap <silent> <Leader>ao :Gina browse --extract :<CR>


command! -nargs=? PR Gina browse --scheme=pr <args>
nnoremap <leader>aw :PR<CR>

call extend(g:gina#command#browse#translation_patterns['github\.com'][1],
              \ {'pr':'https://\1/\2/\3/pull/new/%c0'}
              \)
call gina#custom#command#option(
      \ 'commit', '-v|--verbose'
      \)
call gina#custom#command#option(
      \ '/\%(status\|commit\)',
      \ '-u|--untracked-files'
      \)
call gina#custom#command#option(
      \ 'status',
      \ '-b|--branch'
      \)
call gina#custom#command#option(
      \ 'status',
      \ '-s|--short'
      \)
call gina#custom#command#option(
      \ '/\%(commit\|tag\)',
      \ '--restore'
      \)
call gina#custom#mapping#nmap(
      \ 'status', '<C-^>',
      \ ':<C-u>Gina commit<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)
call gina#custom#mapping#nmap(
      \ 'commit', '<C-^>',
      \ ':<C-u>Gina status<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)
call gina#custom#mapping#nmap(
      \ 'status', '<C-6>',
      \ ':<C-u>Gina commit<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)
call gina#custom#mapping#nmap(
      \ 'commit', '<C-6>',
      \ ':<C-u>Gina status<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)
call gina#custom#action#alias(
      \ '/\%(blame\|log\|reflog\)',
      \ 'preview',
      \ 'topleft show:commit:preview',
      \)
call gina#custom#mapping#nmap(
      \ '/\%(blame\|log\|reflog\)',
      \ 'p',
      \ ':<C-u>call gina#action#call(''preview'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)

call gina#custom#action#alias(
      \ '/\%(blame\|log\|reflog\)',
      \ 'changes',
      \ 'topleft changes:of:preview',
      \)
call gina#custom#mapping#nmap(
      \ '/\%(blame\|log\|reflog\)',
      \ 'c',
      \ ':<C-u>call gina#action#call(''changes'')<CR>',
      \ {'noremap': 1, 'silent': 1}
      \)

call gina#custom#execute(
      \ '/\%(ls\|log\|reflog\|grep\)',
      \ 'setlocal noautoread',
      \)
call gina#custom#execute(
      \ '/\%(status\|branch\|ls\|log\|reflog\|grep\)',
      \ 'setlocal cursorline',
      \)

call gina#custom#command#option(
      \ '/\%(branch\|changes\|grep\|log\|show\)',
      \ '--opener', 'vsplit'
      \)
call gina#custom#execute(
      \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
      \ 'setlocal winfixheight',
      \)

call gina#custom#mapping#nmap(
      \ 'branch',
      \ 'dd',
      \ '<Plug>(gina-branch-delete)',
      \ {'mode': 'n', 'silent': 1}
      \)
call gina#custom#mapping#nmap(
      \ 'branch',
      \ 'n',
      \ '<Plug>(gina-branch-new)',
      \ {'nmap': 1, 'silent': 1}
      \)
