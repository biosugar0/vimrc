require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"vim",
		"toml",
		"python",
		"go",
		"hcl",
		"yaml",
		"bash",
		"sql",
	},

	highlight = {
		enable = true,
		disable = {
			"lua",
			"ruby",
			"c_sharp",
			"vue",
		},
	},
	indent = {
		enable = true,
	},
})
