-------------------------------------------------------------------------------
-- コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
-- map/noremap           @            -              -                  @
-- nmap/nnoremap         @            -              -                  -
-- imap/inoremap         -            @              -                  -
-- cmap/cnoremap         -            -              @                  -
-- vmap/vnoremap         -            -              -                  @
-- map!/noremap!         -            @              @                  -
-------------------------------------------------------------------------------
vim.keymap.set("n", "ZZ", "<Nop>", { noremap = true })
vim.keymap.set("n", "<C-d>", "<Nop>", { noremap = true })
-- jjをescに
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set("c", "j", [[getcmdline()[getcmdpos()-2] ==# 'j' ? '<BS><C-c>' : 'j']], { noremap = true, expr = true })
-- change window size
vim.keymap.set("n", "<S-Left>", "<C-w><<CR>", { noremap = true })
vim.keymap.set("n", "<S-Right>", "<C-w>><CR>", { noremap = true })
vim.keymap.set("n", "<S-Up>", "<C-w>-<CR>", { noremap = true })
vim.keymap.set("n", "<S-Down>", "<C-w>+<CR>", { noremap = true })
vim.keymap.set("n", "<leader>vn", "<Cmd>setlocal number!<CR>", { replace_keycodes = false, noremap = true })
vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true })
vim.keymap.set("c", "<Up>", "<C-p>", { noremap = true })
vim.keymap.set("c", "<Down>", "<C-n>", { noremap = true })
vim.keymap.set("c", "}", "<Cmd>ls<CR><Cmd>b<Space>", { replace_keycodes = false, noremap = true })
-- turn off highlight on enter twice
vim.keymap.set("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR>", { replace_keycodes = false, noremap = true, silent = true })
vim.keymap.set("n", "<C-l><C-l>", "<Cmd>nohlsearch<CR>", { replace_keycodes = false, noremap = true, silent = true })

-- tab operation
vim.keymap.set("n", "qq", "<Cmd>tabclose<CR>", { replace_keycodes = false, noremap = true, silent = true })

-- smart zero
vim.keymap.set("n", "0", [[getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^']], { noremap = true, expr = true })

-- macro playback
vim.keymap.set("n", "Q", "@a")

-- a"などでスペースを入れない
vim.keymap.set("o", [[a']], [[2i']])
vim.keymap.set("x", [[a']], [[2i']])
vim.keymap.set("o", [[a"]], [[2i"]])
vim.keymap.set("x", [[a"]], [[2i"]])
vim.keymap.set("o", [[a`]], [[2i`]])
vim.keymap.set("x", [[a`]], [[2i`]])
