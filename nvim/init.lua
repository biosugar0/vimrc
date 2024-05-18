vim.env.VIMHOME = vim.fn.expand("<sfile>:p:h")
vim.g.rc_dir = vim.env.VIMHOME
vim.g.mapleader = " " -- デフォルトのマップリーダーをスペースに変更
vim.g.maplocalleader = " " -- デフォルトのローカルマップリーダーをスペースに変更
local set = vim.opt

if vim.fn.has("vim_starting") == 1 then
	vim.o.packpath = ""
	set.encoding = "utf-8"

	vim.g.colorterm = os.getenv("COLORTERM")
	if vim.fn.exists("+termguicolors") == 1 then
		vim.o.termguicolors = true -- true color
	end
	-- 必要ないデフォルトプラグインを読み込まない
	--
	vim.g.did_install_default_menus = 1
	vim.g.did_install_syntax_menu = 1
	vim.g.loaded_2html_plugin = 1
	vim.g.loaded_getscript = 1
	vim.g.loaded_getscriptPlugin = 1
	vim.g.loaded_gzip = 1
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwFileHandlers = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.loaded_netrwSettings = 1
	vim.g.loaded_rrhelper = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_zipPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.no_gvimrc_example = 1
	vim.g.no_vimrc_example = 1
	vim.g.skip_loading_mswin = 1
	vim.g.loaded_man = 1
	vim.g.loaded_tutor_mode_plugin = 1
	-- ビジュアルベルを無効化
	set.visualbell = false
	if vim.fn.exists("&belloff") then
		set.belloff = "all"
	end
	-- タイムアウトを有効化
	set.timeout = true
	set.ttimeout = true
	set.ttimeoutlen = 100
	set.updatetime = 800
	vim.env.CACHE = vim.fn.expand("~/.cache")
end

require("biosugar0")
set.secure = true -- セキュアモード (セキュアモードでは、外部からのコマンド実行を禁止)
