-- treesitter configuration
vim.treesitter.language.register("json", "tfstate")
vim.treesitter.language.register("terraform", "tf")
vim.treesitter.language.register("terraform", "tfvars")
vim.treesitter.language.register("bash", "zsh")
vim.treesitter.language.register("gitcommit", "gina-commit")

local conf = {
	ensure_installed = {
		"vim",
		"toml",
		"python",
		"go",
		"hcl",
		"yaml",
		"bash",
		"sql",
		"json",
		"terraform",
		"lua",
		"gitcommit",
	},

	highlight = {
		enable = true,
		disable = {
			"ruby",
			"c_sharp",
			"vue",
		},
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			lua = "-- %s",
			toml = "# %s",
			yaml = "# %s",
		},
	},
	matchup = { enable = true, include_match_words = true },
}
require("nvim-treesitter.configs").setup(conf)
