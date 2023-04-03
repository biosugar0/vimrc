require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<C-q>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	filetypes = {
		yaml = true,
		markdown = true,
		["gina-commit"] = true,
		["."] = true,
	},
	copilot_node_command = "node", -- Node.js version must be > 16.x
	server_opts_overrides = {},
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "MyAutoCmd",
	pattern = "*",
	command = [[if &filetype == 'gina-commit' | setlocal buflisted | endif]],
})

require("copilot.auth").signin() -- Sign in to Copilot
