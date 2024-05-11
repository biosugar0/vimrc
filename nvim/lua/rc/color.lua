local M = {}
local palette = {}

-- global settings
local incsearch = "#175655"
local search = "#213F72"
local diff = {
	add = {
		bg = "#002800",
	},
	delete = {
		bg = "#350001",
	},
	change = {
		bg = "#2b2a00",
	},
	text = {
		bg = "#485400",
	},
}

palette["gruvbox-material"] = function()
	return {
		base = {
			black = "#000000",
			red = "#EA6962",
			green = "#A9B665",
			yellow = "#D8A657",
			blue = "#7DAEA3",
			magenta = "#D3869B",
			cyan = "#89B482",
			white = "#D4BE98",
			grey = "#807569",
			orange = "#E78A4E",
			purple = "#CBA6F7", -- TODO: Temporary settings
			background = "#000000",
			empty = "#1C1C1C",
			info = "#FFFFAF",
			incsearch = incsearch,
			search = search,
			visual = "#1D4647",
		},
		misc = {
			completion = {
				match = "#7DAEA3",
			},
			pointer = {
				red = "#E27878",
				blue = "#5F87D7",
			},
			diff = diff,
			-- NOTE: Copy from catppuccino
			sandwich = {
				add = "#0E4A1D",
				delete = "#541010",
				change = "#544E10",
			},
			vert_split = "#504945",
			scrollbar = {
				bar = "#3A3A3A",
				search = "#00AFAF",
			},
			hlslens = {
				lens = {
					fg = "#889EB5",
					bg = "#283642",
				},
				near = {
					fg = "NONE",
					bg = search,
				},
				float = {
					fg = "NONE",
					bg = search,
				},
			},
		},
	}
end

palette["catppuccin"] = function()
	local catppuccin_palette = require("catppuccin.palettes").get_palette("mocha")

	return {
		base = {
			black = catppuccin_palette.crust, -- #11111b
			red = catppuccin_palette.red, -- #F38BA8
			green = catppuccin_palette.green, -- #A6E3A1
			yellow = catppuccin_palette.yellow, -- #F9E2AF
			blue = catppuccin_palette.blue, -- #89B4FA
			magenta = catppuccin_palette.pink, -- #F5C2E7
			cyan = catppuccin_palette.lavender, -- #B4BEFE
			white = catppuccin_palette.rosewater, -- #F5E0DC
			grey = catppuccin_palette.overlay0, -- #6C7086
			orange = catppuccin_palette.peach, -- #FAB387
			purple = catppuccin_palette.mauve, -- #CBA6F7
			background = catppuccin_palette.crust, -- #11111b
			empty = catppuccin_palette.crust, -- #11111B
			info = catppuccin_palette.yellow, -- #F9E2AF
			incsearch = incsearch,
			search = search,
			visual = catppuccin_palette.surface0, -- #313244
			vert_split = catppuccin_palette.surface0, -- #313244
			inlay_hint = catppuccin_palette.surface2, -- #585B70
		},
		misc = {
			completion = {
				match = catppuccin_palette.sky, -- #89DCEB
			},
			pointer = {
				red = "#f17497",
				blue = "#71a4f9",
			},
			diff = diff,
			sandwich = {
				add = "#0E4A1D",
				delete = "#541010",
				change = "#544E10",
			},
			scrollbar = {
				bar = catppuccin_palette.surface0, -- #313244
				search = catppuccin_palette.sky, -- #89DCEB
			},
			hlslens = {
				lens = {
					fg = catppuccin_palette.overlay0, -- #9399B2
					bg = catppuccin_palette.surface0, -- #313244
				},
				near = {
					fg = "NONE",
					bg = search,
				},
				float = {
					fg = "NONE",
					bg = search,
				},
			},
		},
	}
end

M.base = function()
	return palette[vim.env.NVIM_COLORSCHEME]().base
end
M.misc = function()
	return palette[vim.env.NVIM_COLORSCHEME]().misc
end

return M
