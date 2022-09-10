vim.g.copilot_no_maps = true
vim.g.copilot_hide_during_completion = false
vim.g.copilot_node_command = "~/.volta/bin/node"
vim.keymap.set("i", "<c-l>", [[copilot#Accept()]], {
	expr = true,
	script = true,
})

vim.keymap.set("i", "<M-]>", [[<Cmd>call copilot#Next()<CR>]])
vim.keymap.set("i", "<M-[>", [[<Cmd>call copilot#Previous()<CR>]])
