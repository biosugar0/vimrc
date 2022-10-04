vim.g.copilot_no_maps = true
vim.g.copilot_hide_during_completion = false
vim.g.copilot_node_command = "~/.volta/bin/node"
vim.keymap.set("i", "<c-l>", [[copilot#Accept()]], {
	replace_keycodes = false,
	expr = true,
	script = true,
})

vim.keymap.set("i", "<M-]>", [[<Cmd>call copilot#Next()<CR>]], { replace_keycodes = false })
vim.keymap.set("i", "<M-[>", [[<Cmd>call copilot#Previous()<CR>]], { replace_keycodes = false })
