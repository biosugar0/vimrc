local conf = {
	autostart = true,
	cursor = "", -- cursor shape (need nerd font)
	linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
	type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
	fancy = {
		enable = true, -- enable fancy mode
		head = { cursor = "⊛", texthl = "SmoothCursorAqua", linehl = nil },
		body = {
			{ cursor = "⊛", texthl = "SmoothCursorAqua" },
			{ cursor = "⊛", texthl = "SmoothCursorAqua" },
			{ cursor = "•", texthl = "SmoothCursorAqua" },
			{ cursor = "•", texthl = "SmoothCursorAqua" },
			{ cursor = ".", texthl = "SmoothCursorAqua" },
			{ cursor = ".", texthl = "SmoothCursorAqua" },
		},
		tail = { cursor = nil, texthl = "SmoothCursorAqua" },
	},
	speed = 25, -- max is 100 to stick to your current position
	intervals = 35, -- tick interval
	priority = 10, -- set marker priority
	timeout = 3000,
	threshold = 3,
	texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
}

require("smoothcursor").setup(conf)
