vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.opt.rtp:append("~/.cache/dein/repos/github.com/vim-denops/denops.vim")
vim.opt.rtp:append("~/.cache/dein/repos/github.com/Shougo/ddc.vim")
vim.opt.rtp:append("~/.cache/dein/repos/github.com/Shougo/pum.vim")
vim.opt.rtp:append("~/.cache/dein/repos/github.com/Shougo/ddc-around")
vim.opt.rtp:append("~/.cache/dein/repos/github.com/Shougo/ddc-sorter_rank")
vim.opt.rtp:append("~/.cache/dein/repos/github.com/Shougo/ddc-matcher_head")

local ddc = {
	patch_global = vim.fn["ddc#custom#patch_global"],
	patch_buffer = vim.fn["ddc#custom#patch_buffer"],
	patch_filetype = vim.fn["ddc#custom#patch_filetype"],
	set_buffer = vim.fn["ddc#custom#set_buffer"],
	set_context = vim.fn["ddc#custom#set_context"],
}

ddc.patch_global("sources", { "around" })
ddc.patch_global("sourceOptions", {
	_ = {
		ignoreCase = true,
		matchers = { "matcher_head" },
		sorters = { "sorter_rank" },
	},
	around = {
		mark = "A",
	},
})

ddc.patch_global("autoCompleteEvents", {
	"InsertEnter",
	"TextChangedI",
	"TextChangedP",
	"CmdlineEnter",
	"CmdlineChanged",
})

ddc.patch_global("completionMenu", "pum.vim")

vim.fn["ddc#enable"]()

vim.keymap.set(
	"i",
	[[<Tab>]],
	[[ddc#map#pum_visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#manual_complete()]],
	{ noremap = false, expr = true }
)

