local api = vim.api
local fn = vim.fn
local bo = vim.bo

local MyAutoCmd = api.nvim_create_augroup("MyAutoCmd", { clear = true })

local ftdetect_event = { "FileType", "Syntax", "BufNewFile", "BufNew", "BufRead" }
api.nvim_create_autocmd(ftdetect_event, {
	group = MyAutoCmd,
	pattern = "*",
	callback = function()
		api.nvim_command("filetype detect")
		if bo.filetype == "gina-commit" or bo.filetype == "ai-review" then
			bo.buflisted = true
		end
		if fn.match(fn.expand("%"), "ai-review") == 0 then
			bo.filetype = "ai-review"
		end
	end,
})

-- 保存時に存在しないディレクトリを作成
api.nvim_create_autocmd({ "BufWritePre" }, {
	group = MyAutoCmd,
	pattern = "*",
	callback = function()
		local dir = fn.expand("<afile>:p:h")
		local force = vim.v.cmdbang

		if fn.isdirectory(dir) == 1 then
			return
		end

		if not (force == 1) then
			local result = fn.confirm(string.format('"%s" does not exist. Create?', dir), "&y\n&n")
			if not (result == 1) then
				print("Canceled")
			end
			fn.mkdir(dir, "p")
		end
	end,
	once = false,
})

-- 末尾の空白削除
api.nvim_create_autocmd("FileType", {
	group = MyAutoCmd,
	pattern = { "go", "sql", "python", "vim", "sh", "lua" },
	command = [[autocmd BufWritePre * :%s/\s\+$//ge]],
})

--ファイルをひらいたとき最後にカーソルがあった場所に移動
api.nvim_create_autocmd("BufReadPost", {
	group = MyAutoCmd,
	pattern = "*",
	command = [[if line("'\"") >= 1 && line("'\"") <= line("$")  |   exe "normal! g`\""  | endif]],
})

-- BufWinEnterでカーソル位置を中央にする
api.nvim_create_autocmd("BufWinEnter", {
	group = MyAutoCmd,
	pattern = "*",
	command = [[if empty(&buftype) && line('.') > winheight(0) / 3 * 2 | execute 'normal! zz' .. repeat("\<C-y>", winheight(0) / 6) | endif]],
})

-- フォーカスが当たったら英数入力にする。
if fn.executable("osascript") == 1 then
	local force_alphanumeric_input_command = [[
    osascript -e 'tell application "System Events" to key code 102' &
    ]]
	api.nvim_create_autocmd("FocusGained", {
		group = MyAutoCmd,
		pattern = "*",
		callback = function()
			fn.system(force_alphanumeric_input_command)
		end,
	})
end
