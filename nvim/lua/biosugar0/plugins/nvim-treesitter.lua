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
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["ib"] = "@block.inner",
				["ab"] = "@block.outer",
				["c"] = "@comment.outer",
				["if"] = "@function.inner",
				["af"] = "@function.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<M-s>"] = "@parameter.inner",
			},
			swap_previous = {
				["<M-S-s>"] = "@parameter.inner",
			},
		},
	},
})
