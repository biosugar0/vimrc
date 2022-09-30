require("biosugar0/util")
local MyAutoCmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })
-- Note: filetype detect does not work on startup
vim.api.nvim_create_autocmd({ "FileType", "Syntax", "BufNewFile", "BufNew", "BufRead" }, {
	group = MyAutoCmd,
	pattern = "*",
	command = [[  filetype detect ]],
})
-- 保存時に存在しないディレクトリを作成
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = MyAutoCmd,
	pattern = "*",
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")
		local force = vim.v.cmdbang

		if vim.fn.isdirectory(dir) == 1 then
			return
		end

		if not (force == 1) then
			local result = vim.fn.confirm(string.format('"%s" does not exist. Create?', dir), "&y\n&n")
			if not (result == 1) then
				print("Canceled")
			end
			vim.fn.mkdir(vim.fn.iconv(dir, vim.o.encoding, vim.o.encoding), "p")
		end
	end,
	once = false,
})

-- 末尾の空白削除
vim.api.nvim_create_autocmd("FileType", {
	group = MyAutoCmd,
	pattern = { "go", "sql", "python", "vim", "sh", "lua" },
	command = [[autocmd BufWritePre * :%s/\s\+$//ge]],
})

--ファイルをひらいたとき最後にカーソルがあった場所に移動
vim.api.nvim_create_autocmd("BufReadPost", {
	group = MyAutoCmd,
	pattern = "*",
	command = [[if line("'\"") >= 1 && line("'\"") <= line("$")  |   exe "normal! g`\""  | endif]],
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = MyAutoCmd,
	pattern = "*",
	command = [[if empty(&buftype) && line('.') > winheight(0) / 3 * 2 | execute 'normal! zz' .. repeat("\<C-y>", winheight(0) / 6) | endif]],
})

-- フォーカスが当たったら英数入力にする。
if vim.fn.executable("osascript") == 1 then
	local force_alphanumeric_input_command = [[
    osascript -e 'tell application "System Events" to key code 102' &
    ]]
	vim.api.nvim_create_autocmd("FocusGained", {
		group = MyAutoCmd,
		pattern = "*",
		callback = function()
			vim.fn.system(force_alphanumeric_input_command)
		end,
	})
end

-- for onsidian markdown link
local memodir = os.getenv("MEMO_DIRECTORY")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = memodir .. "*",
	group = MyAutoCmd,
	callback = function()
		local obsidian_suffix = ".md"
		vim.opt_local.path:append(memodir .. "/**")
		vim.opt.suffixesadd:append(obsidian_suffix)
		local function open_file_or_create_new()
			local path = vim.fn.expand("<cfile>")
			if vim.fn.empty(path) == 1 then
				return
			end
			try_catch({
				try = function()
					vim.cmd([[exe 'norm!gf']])
				end,
				catch = function(error)
					print("New File.")
					new_path = vim.fn.fnamemodify(vim.fn.expand("%:p:h") .. "/" .. path, ":p")
					if not (vim.fn.empty(vim.fn.fnamemodify(new_path, ":e"))) then
						return vim.fn.execute("edit " .. new_path)
					end
				end,
			})
			if vim.fn.filereadable(new_path.suffix) then
				return vim.fn.execute("edit " .. new_path .. obsidian_suffix)
			end
			return vim.fn.execute("edit " .. new_path .. obsidian_suffix)
		end
		vim.keymap.set("n", "gf", open_file_or_create_new, { noremap = true })
	end,
})
