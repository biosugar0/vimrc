vim.g.copilot_no_maps = true
vim.g.copilot_hide_during_completion = false
vim.g.copilot_node_command = "~/.volta/bin/node"
vim.keymap.set("n", "<Leader>p", "<Cmd>Copilot enable<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>p", "<Cmd>Copilot disable<CR>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-l>", [[copilot#Accept()]], {
    expr = true,
    script = true,
})
vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { noremap = false })
vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { noremap = false })
