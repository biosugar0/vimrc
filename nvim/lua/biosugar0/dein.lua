if not (vim.fn.isdirectory(vim.env.CACHE) == 1) then
	vim.fn.mkdir(vim.env.CAHCE, "p")
end

local dein_dir = vim.env.CACHE .. "/dein"
local dein_repo_dir = dein_dir .. "/repos/github.com/Shougo/dein.vim"

if not (vim.fn.isdirectory(dein_dir) == 1) then
	vim.fn.mkdir(dein_dir, "p")
end
-- dein.vimがインストールされていなかったらインストール
if not (string.match(vim.o.runtimepath, "/dein.vim") == 1) then
	if not (vim.fn.isdirectory(dein_repo_dir) == 1) then
		os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_repo_dir)
	end
	vim.opt.runtimepath:append(dein_repo_dir)
end

-- dein options
vim.g["dein#auto_recache"] = true
vim.g["dein#lazy_rplugins"] = true
vim.g["dein#install_progress_type"] = "floating"
vim.g["dein#install_check_diff"] = true
vim.g["dein#enable_notification"] = true
vim.g["dein#install_check_remote_threshold"] = 24 * 60 * 60
vim.g["dein#auto_remote_plugins"] = false
vim.g["dein#install_copy_vim"] = true

if vim.fn["dein#load_state"](dein_dir) == 1 then
	local toml = vim.g.rc_dir .. "/dein.toml"
	local lazy_toml = vim.g.rc_dir .. "/dein_lazy.toml"
	local ft_toml = vim.g.rc_dir .. "/ft.toml"

	vim.fn["dein#begin"](dein_dir, { vim.fn.expand("<sfile>"), toml, lazy_toml, ft_toml })

	if vim.fn.filereadable(vim.fn.expand(toml)) == 1 then
		vim.fn["dein#load_toml"](toml, { lazy = 0 })
	end

	if vim.fn.filereadable(vim.fn.expand(lazy_toml)) == 1 then
		vim.fn["dein#load_toml"](lazy_toml, { lazy = 1 })
	end

	if vim.fn.filereadable(vim.fn.expand(ft_toml)) == 1 then
		vim.fn["dein#load_toml"](ft_toml, { lazy = 1 })
	end

	vim.fn["dein#end"]()
	vim.fn["dein#save_state"]()
end
