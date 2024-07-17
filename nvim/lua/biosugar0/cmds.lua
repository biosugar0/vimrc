local set = vim.opt
local let = vim.o

if vim.fn.executable("rg") then
	let.grepprg = "rg --vimgrep --hidden"
	set.grepformat = [[%f:%l:%c:%m]]
end

local autoQuickfix = vim.api.nvim_create_augroup("AutoQuickfix", { clear = true })
vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
	group = "AutoQuickfix",
	pattern = "[^l]*",
	command = [[cwindow]],
})
vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
	group = "AutoQuickfix",
	pattern = "l*",
	command = [[lwindow]],
})

local function get_syn_id(transparent)
	local synid = vim.fn.synID(vim.fn.line("."), vim.fn.line("."), 1)
	if transparent == 1 then
		return vim.fn.synIDtrans(synid)
	else
		return synid
	end
end

local function get_syn_attr(synid)
	local name = vim.fn.synIDattr(synid, "name")
	local ctermfg = vim.fn.synIDattr(synid, "fg", "cterm")
	local ctermbg = vim.fn.synIDattr(synid, "bg", "cterm")
	local guifg = vim.fn.synIDattr(synid, "fg", "gui")
	local guibg = vim.fn.synIDattr(synid, "bg", "gui")
	local result = {
		name = name,
		ctermfg = ctermfg,
		ctermbg = ctermbg,
		guifg = guifg,
		guibg = guibg,
	}

	return result
end

local function get_syn_info()
	local baseSyn = get_syn_attr(get_syn_id(0))
	print(
		"name: "
			.. baseSyn.name
			.. " ctermfg: "
			.. baseSyn.ctermfg
			.. " ctermbg: "
			.. baseSyn.ctermbg
			.. " guifg: "
			.. baseSyn.guifg
			.. " guibg: "
			.. baseSyn.guibg
	)
	local linkedSyn = get_syn_attr(get_syn_id(1))
	print("link to")
	print(
		"name: "
			.. linkedSyn.name
			.. " ctermfg: "
			.. linkedSyn.ctermfg
			.. " ctermbg: "
			.. linkedSyn.ctermbg
			.. " guifg: "
			.. linkedSyn.guifg
			.. " guibg: "
			.. linkedSyn.guibg
	)
end

vim.api.nvim_create_user_command("SyntaxInfo", get_syn_info, { nargs = 0, desc = "show syntac infomation" })

function YankDiagnosticInRange()
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics = vim.diagnostic.get(bufnr)
	if #diagnostics == 0 then
		print("No diagnostics to yank")
		return
	end

	-- ビジュアルモードで選択された範囲を取得
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	local lines = {}
	for _, diagnostic in ipairs(diagnostics) do
		local diagnostic_line = diagnostic.lnum + 1
		if diagnostic_line >= start_line and diagnostic_line <= end_line then
			local relative_line = diagnostic_line - start_line + 1
			table.insert(lines, "Line " .. relative_line .. ": " .. diagnostic.message)
		end
	end

	if #lines == 0 then
		print("No diagnostics in the selected range")
		return
	end

	local result = table.concat(lines, "\n")
	vim.fn.setreg("+", result)
	print("Diagnostics in the selected range yanked to clipboard")
end

vim.api.nvim_set_keymap("v", "<Leader>y", ":lua YankDiagnosticInRange()<CR>", { noremap = true, silent = true })
