require("biosugar0/util")
local MyAutoCmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })
-- ftdetect
-- Note: filetype detect does not work on startup
local ftdetect_event = { "FileType", "Syntax", "BufNewFile", "BufNew", "BufRead" }
vim.api.nvim_create_autocmd(ftdetect_event, {
	group = MyAutoCmd,
	pattern = "*",
	-- this function run 'filetype detect' vim command
	-- if filetype gina-commit , set buflisted
	-- if buffer name prefix ai-review, set filetype ai-review
	callback = function()
		vim.cmd("filetype detect")
		if vim.bo.filetype == "gina-commit" then
			vim.bo.buflisted = true
		end
		if vim.fn.match(vim.fn.expand("%"), "ai-review") == 0 then
			vim.bo.filetype = "ai-review"
		end
	end,
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
			vim.fn.mkdir(dir, "p")
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

-- BufWinEnterでカーソル位置を中央にする
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
