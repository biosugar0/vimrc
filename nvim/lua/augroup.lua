require("util")

-- 保存時に存在しないディレクトリを作成
local vimrc_auto_mkdir = vim.api.nvim_create_augroup("vimrc-auto-mkdir", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vimrc_auto_mkdir,
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
local trim_space = vim.api.nvim_create_augroup("trim-space", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = trim_space,
	pattern = { "go", "sql", "python", "vim", "sh", "lua" },
	command = [[autocmd BufWritePre * :%s/\s\+$//ge]],
})

--ファイルをひらいたとき最後にカーソルがあった場所に移動
local restore_cursor = vim.api.nvim_create_augroup("restore-cursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = restore_cursor,
	pattern = "*",
	command = [[if line("'\"") >= 1 && line("'\"") <= line("$")  |   exe "normal! g`\""  | endif]],
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = restore_cursor,
	pattern = "*",
	command = [[if empty(&buftype) && line('.') > winheight(0) / 3 * 2 | execute 'normal! zz' .. repeat("\<C-y>", winheight(0) / 6) | endif]],
})

local vimrcAutoCreatefile = vim.api.nvim_create_augroup("vimrcAutoCreatefile", { clear = true })
local memodir = os.getenv("MEMO_DIRECTORY")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = memodir .. "*",
	group = vimrcAutoCreatefile,
	callback = function()
		vim.opt_local.path:append(memodir .. "/**")
		vim.opt.suffixesadd:append(".md")
		local function open_file_or_create_new()
			local path = vim.fn.expand("<cfile>")
			if vim.fn.enpty(path) then
				return
			end
			try_catch({
				try = function()
					vim.cmd([[exe 'norm!gf']])
				end,
				catch = function(error)
					print("New File.")
					new_path = vim.fn.fnamemodify(vim.fn.expand("%:p:h"), "/" .. path, ":p")
					if not (vim.fn.empty(vim.fn.fnamemodify(new_path, ":e"))) then
						return vim.fn.execute("edit " .. new_path)
					end
				end,
			})
			suffixes = vim.fn.split(vim.opt.suffixesadd, ",")

			for i, suffix in ipairs(suffixes) do
				if vim.fn.filereadable(new_path.suffix) then
					return vim.fn.execute("edit " .. new_path .. suffix)
				end
			end

			return vim.fn.execute("edit " .. new_path .. suffixes[0])
		end
		vim.keymap.set("n", "gf", open_file_or_create_new, { noremap = true })
	end,
})
