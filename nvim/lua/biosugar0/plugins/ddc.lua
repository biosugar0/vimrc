local util = require("biosugar0.util")
local ddc = {
	patch_global = vim.fn["ddc#custom#patch_global"],
	patch_buffer = vim.fn["ddc#custom#patch_buffer"],
	patch_filetype = vim.fn["ddc#custom#patch_filetype"],
	set_buffer = vim.fn["ddc#custom#set_buffer"],
	set_context = vim.fn["ddc#custom#set_context"],
}
ddc.patch_global("sources", { "around", "file", "rg", "dictionary" })
ddc.patch_global("cmdlineSources", { "cmdline-history", "input", "file", "around" })

local sopts = {}
sopts["_"] = {
	ignoreCase = true,
	matchers = { "matcher_fuzzy" },
	sorters = { "sorter_fuzzy" },
	converters = { "converter_remove_overlap", "converter_truncate_abbr" },
}
sopts["around"] = {
	mark = "A",
	matchers = { "matcher_head", "matcher_length" },
}
sopts["cmdline"] = {
	mark = "cmdline",
	forceCompletionPattern = [[\S/\S*]],
	dup = true,
}
sopts["input"] = {
	mark = "input",
	forceCompletionPattern = [[\S/\S*]],
	isVolatile = true,
	dup = true,
}
sopts["nvim-lsp"] = {
	mark = "lsp",
	forceCompletionPattern = [[\.|=|->|"\w+/*]],
	ignoreCase = true,
	isVolatile = true,
}
sopts["dictionary"] = {
	matchers = { "matcher_fuzzy" },
	sorters = { "sorter_fuzzy" },
	converters = { "converter_fuzzy" },
	maxItems = 15,
	mark = "D",
	minAutoCompleteLength = 3,
}
sopts["cmdline-history"] = {
	mark = "history",
	sorters = {},
}
sopts["shell-history"] = { mark = "shell" }
sopts["zsh"] = {
	mark = "zsh",
	isVolatile = true,
	forceCompletionPattern = [[\S/\S*]],
}
sopts["rg"] = {
	mark = "rg",
	matchers = { "matcher_head", "matcher_length" },
	minAutoCompleteLength = 5,
	enabledIf = "finddir('.git', ';') != ''",
}
sopts["file"] = {
	mark = "file",
	isVolatile = true,
	minAutoCompleteLength = 1000,
	forceCompletionPattern = [[\S/\S*]],
}
sopts["vsnip"] = {
	dup = true,
	mark = "snip",
}
sopts["skkeleton"] = {
	mark = "skk",
	converters = {},
	matchers = { "skkeleton" },
	sorters = {},
	minAutoCompleteLength = 2,
	maxCandidates = 50,
    isVolatile: true,
}

ddc.patch_global("sourceOptions", sopts)

ddc.patch_filetype({ "help", "markdown", "gitcommit" }, "sources", { "input", "around", "rg" })
ddc.patch_filetype(
	{ "typescript", "go", "python", "hcl", "toml" },
	"sources",
	{ "input", "nvim-lsp", "around", "vsnip", "dictionary" }
)
ddc.patch_filetype({ "FineCmdlinePrompt" }, {
	keywordPattern = [[[0-9a-zA-Z_:#]*]],
	sources = { "cmdline-history", "cmdline", "around" },
	specialBufferCompletion = true,
})

ddc.patch_global("autoCompleteEvents", {
	"InsertEnter",
	"TextChangedI",
	"TextChangedP",
	"CmdlineEnter",
	"CmdlineChanged",
})
ddc.patch_global("completionMenu", "pum.vim")
vim.fn["pum#set_option"]("border", "rounded")
vim.fn["pum#set_option"]("max_width", 80)
vim.fn["pum#set_option"]("padding", true)

ddc.set_context("go", function()
	local syntaxIn = vim.fn["ddc#syntax#in"]("TSComment")
	if syntaxIn == 1 then
		return { sources = { "around" } }
	end
	return {}
end)
ddc.patch_global("sourceParams", {
	dictionary = {
		dictPaths = { "/usr/share/dict/words" },
		smartCase = true,
		showMenu = false,
	},
})
vim.fn["ddc#enable"]()

vim.keymap.set(
	"i",
	[[<Tab>]],
	[[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ddc#map#pum_visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#can_complete() ? ddc#manual_complete() : '<Tab>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"s",
	[[<Tab>]],
	[[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : ddc#map#pum_visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#can_complete() ? ddc#manual_complete() : '<Tab>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"i",
	[[<S-Tab>]],
	[[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-Tab>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"s",
	[[<S-Tab>]],
	[[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<S-Tab>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"i",
	[[<C-p>]],
	[[pum#visible() ? '<Cmd>call pum#map#select_relative(-1)<CR>' : '<Cmd>call ddc#map#manual_complete()<CR><Cmd>call pum#map#select_relative(-1)<CR>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"i",
	[[<Esc>]],
	[[pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<Esc>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"s",
	[[<C-n>]],
	[[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' :  '<C-n>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"i",
	[[<C-n>]],
	[[pum#visible() ? '<Cmd>call pum#map#select_relative(+1)<CR>' : '<Cmd>call ddc#map#manual_complete()<CR><Cmd>call pum#map#select_relative(+1)<CR>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"i",
	[[<CR>]],
	[[pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : lexima#expand('<LT>CR>', 'i')]],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"i",
	[[<C-e>]],
	[[pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<C-e>']],
	{ noremap = true, expr = true }
)

vim.keymap.set(
	"i",
	[[<C-k>]],
	[[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-k>']],
	{ noremap = false, expr = true }
)
vim.keymap.set(
	"s",
	[[<C-k>]],
	[[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-k>']],
	{ noremap = false, expr = true }
)

vim.api.nvim_create_autocmd("User", {
	pattern = "PumCompleteDone",
	callback = function()
		vim.fn["vsnip_integ#on_complete_done"](vim.g["pum#completed_item"])
	end,
})

-- For command line mode completion
vim.keymap.set(
	"c",
	"<Tab>",
	[[pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : exists('b:ddc_cmdline_completion') ? ddc#manual_complete() : nr2char(&wildcharm)]],
	{ noremap = true, expr = true }
)
vim.keymap.set("c", "<S-Tab>", [[<Cmd>call pum#map#insert_relative(-1)<CR>]], { noremap = true, expr = false })
vim.keymap.set("c", "<C-c>", [[<Cmd>call pum#map#cancel()<CR>]], { noremap = true, expr = false })
vim.keymap.set("c", "<C-o>", [[<Cmd>call pum#map#confirm()<CR>]], { noremap = true, expr = false })

local prev_buffer_config

function CommandlinePost()
	pcall(vim.keymap.del, "c", "<Tab>", { silent = true, buffer = 0 })
	-- Restore sources
	if prev_buffer_config ~= nil then
		ddc.set_buffer(prev_buffer_config)
		prev_buffer_config = nil
	else
		ddc.set_buffer(vim.empty_dict())
	end
	vim.opt.wildcharm = vim.fn.char2nr(util.replace_termcodes("<Tab>"))
end

local function CommandlinePre(mode)
	-- Note: It disables default command line completion!
	vim.opt.wildchar = ("<C-t>"):byte()
	vim.opt.wildcharm = vim.fn.char2nr(util.replace_termcodes("<C-t>"))

	vim.keymap.set(
		"c",
		"<Tab>",
		[[pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : exists('b:ddc_cmdline_completion') ? ddc#manual_complete() : "\<C-t>"]],
		{ noremap = true, expr = true, buffer = 0 }
	)
	-- Overwrite sources
	if prev_buffer_config == nil then
		prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
	end
	if mode == ":" then
		ddc.patch_buffer("cmdlineSources", { "cmdline-history", "cmdline", "around" })
		ddc.patch_buffer("keywordPattern", [[[0-9a-zA-Z_:#]*]])
	else
		ddc.patch_buffer("cmdlineSources", { "around", "line" })
	end
	vim.api.nvim_create_autocmd("User", {
		group = "MyAutoCmd",
		pattern = "DDCCmdlineLeave",
		callback = function()
			CommandlinePost()
		end,
		once = true,
	})

	vim.api.nvim_create_autocmd("InsertEnter", {
		group = "MyAutoCmd",
		buffer = 0,
		callback = function()
			CommandlinePost()
		end,
		once = true,
	})

	vim.fn["ddc#enable_cmdline_completion"]()
	return mode
end

vim.keymap.set("n", ":", function()
	return CommandlinePre(":")
end, { expr = true })
vim.keymap.set("n", "/", function()
	return CommandlinePre("/")
end, { expr = true })
vim.keymap.set("n", "?", function()
	return CommandlinePre("?")
end, { expr = true })

-- skkeleton
local function skkeleton_init()
	vim.fn["skkeleton#config"]({
		eggLikeNewline = true,
		registerConvertResult = true,
		showCandidatesCount = 1,
		globalJisyo = vim.g.globalJisyo,
		userJisyo = vim.g.skk_dir .. "/SKK-JISYO.user",
	})

	local kanaTable = {}
	kanaTable["jj"] = "escape"
	kanaTable["~"] = { "〜", "" }
	kanaTable["..."] = { "…", "" }
	kanaTable["~"] = { "〜", "" }
	kanaTable[", "] = { "、", "" }
	kanaTable["z "] = { "　", "" }
	kanaTable[". "] = { "。", "" }
	kanaTable["( "] = { "（", "" }
	kanaTable[") "] = { "）", "" }
	kanaTable["/ "] = { "・", "" }

	vim.fn["skkeleton#register_kanatable"]("rom", kanaTable)
end

local function skkeleton_post()
	-- Restore current sources
	vim.fn["ddc#custom#patch_buffer"]("sources", vim.b.skkeleton_ddc_sources_backup)
	vim.fn["pum#set_option"]("setline_insert", false)
end

local function skkeleton_pre()
	-- Save current sources
	vim.b.skkeleton_ddc_sources_backup = vim.fn.get(vim.fn["ddc#custom#get_current"](), "sources", {})
	local sources = vim.fn.get(vim.b, "skkeleton_ddc_sources", { "skkeleton" })
	vim.fn["ddc#custom#patch_buffer"]("sources", sources)
	-- call pum#set_option('setline_insert', v:true)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "skkeleton-disable-pre",
	callback = skkeleton_post,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "skkeleton-initialize-pre",
	callback = skkeleton_init,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "skkeleton-enable-pre",
	callback = skkeleton_pre,
})
