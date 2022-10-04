set rtp+=~/.cache/dein/repos/github.com/vim-denops/denops.vim
set rtp+=~/.cache/dein/repos/github.com/Shougo/ddc.vim
set rtp+=~/.cache/dein/repos/github.com/Shougo/pum.vim
set rtp+=~/.cache/dein/repos/github.com/Shougo/ddc-around
set rtp+=~/.cache/dein/repos/github.com/Shougo/ddc-sorter_rank
set rtp+=~/.cache/dein/repos/github.com/Shougo/ddc-matcher_head

call ddc#custom#patch_global('sources',
\  ['around']
\)

call ddc#custom#patch_global('sourceOptions', {
\  '_': {
\    'ignoreCase': v:true,
\    'matchers': ['matcher_head'],
\    'sorters': ['sorter_rank'],
\  },
\  'around': {
\    'mark': 'A',
\  },
\})


call ddc#custom#patch_global('autoCompleteEvents', [
\  'InsertEnter', 'TextChangedI', 'TextChangedP',
\  'CmdlineEnter', 'CmdlineChanged',
\])
call ddc#custom#patch_global('completionMenu', 'pum.vim')

call ddc#enable()

inoremap <silent><expr> <TAB> ddc#map#pum_visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#manual_complete()
