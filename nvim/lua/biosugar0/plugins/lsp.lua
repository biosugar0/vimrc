local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts)
	vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "<space>q", vim.lsp.diagnostic.set_loclist, bufopts)
	vim.keymap.set("n", ",f", vim.lsp.buf.formatting, bufopts)
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.diagnostic.config({ virtual_text = false, float = true })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

local nvim_lsp = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local settings = {
	gopls = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			analyses = {
				nonewvars = true,
				unusedparams = true,
			},
			hints = {
				comstantValues = true,
				patameterNames = true,
				rangeVariableTypes = true,
				assignVariableTypes = true,
				compositeLiteralTypes = true,
				compositeLiteralFields = true,
				functionTypeParameters = true,
			},
		},
	},
}

vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {
			handlers = handlers,
		}
		opts.on_attach = on_attach
		opts.capabilities = capabilities
		opts.settings = settings[target], nvim_lsp[server_name].setup(opts)
	end,
})
