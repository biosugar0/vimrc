require("obsidian").setup({
	dir = "~/memo",
	daily_notes = {
		folder = "daily",
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
