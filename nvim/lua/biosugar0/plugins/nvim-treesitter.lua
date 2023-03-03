local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.tf = "hcl"
ft_to_parser.terraform = "hcl"
ft_to_parser.tfvars = "hcl"

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
}
require("nvim-treesitter.configs").setup(conf)
