require("obsidian").setup({
	dir = "~/memo",
	notes_subdir = "home",
	daily_notes = {
		folder = "home/daily",
	},
	templates = {
		subdir = "home/template/",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
	},
	use_advanced_uri = true,
})

-- obsidian
vim.keymap.set("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })
