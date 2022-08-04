vim.cmd('augroup MyAutoCmd')
vim.cmd('autocmd!')
vim.cmd('augroup END')
local o = vim.o

if vim.fn.has('vim_starting') == 1 then
	-- Disable packpath
	vim.o.packpath = ''

    -- True color support
    vim.g.colorterm = os.getenv("COLORTERM")
	if (vim.g.colorterm == "truecolor" or vim.g.colorterm == "24bit" or vim.g.colorterm == "" ) then
		if vim.fn.exists("+termguicolors") then
			o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
			o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
			o.termguicolors = true
		end
	end

	-- Disable default plugins
	vim.g.did_install_default_menus = 1
	vim.g.did_install_syntax_menu  = 1
	vim.g.loaded_2html_plugin = 1
	vim.g.loaded_getscript    = 1
	vim.g.loaded_getscriptPlugin  = 1
	vim.g.loaded_gzip = 1
	vim.g.loaded_netrw              = 1
	vim.g.loaded_netrwFileHandlers  = 1
	vim.g.loaded_netrwPlugin        = 1
	vim.g.loaded_netrwSettings      = 1
	vim.g.loaded_rrhelper           = 1
	vim.g.loaded_tar                = 1
	vim.g.loaded_tarPlugin          = 1
	vim.g.loaded_vimball            = 1
	vim.g.loaded_vimballPlugin      = 1
	vim.g.loaded_zipPlugin          = 1
	vim.g.loaded_zip                = 1
	vim.g.no_gvimrc_example         = 1
	vim.g.no_vimrc_example          = 1
	vim.g.skip_loading_mswin        = 1
	vim.g.loaded_man                = 1
	vim.g.loaded_tutor_mode_plugin  = 1

	o.errorbells = false
	o.visualbell = false

	if vim.fn.exists("&belloff") then
		o.belloff = "all"
	end

	-- Timeout
	o.timeout = true
	o.ttimeout = true
	o.timeoutlen = 500
	o.ttimeoutlen = 10
	o.updatetime = 2000
end
