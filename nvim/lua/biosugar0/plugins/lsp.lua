-- Capabilities setup
local function setup_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	return capabilities
end

local capabilities = setup_capabilities()
-- Neodev setup
require("neodev").setup()

-- LSP Config
local nvim_lsp = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local function setup_mason_lspconfig()
	local mason_conf = {
		ensure_installed = {
			"bashls",
			"denols",
			"eslint",
			"golangci_lint_ls",
			"gopls",
			"lua_ls",
			"sqlls",
			"terraformls",
			"tsserver",
			"yamlls",
			"pyright",
		},
		automatic_installation = true,
	}
	mason_lspconfig.setup(mason_conf)
end
setup_mason_lspconfig()

-- LSP settings
local settings = {
	yamlls = {
		yaml = {
			keyOrdering = false,
			schemas = require("schemastore").json.schemas(),
		},
	},
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
				constantValues = true,
				parameterNames = true,
				rangeVariableTypes = true,
				assignVariableTypes = true,
				compositeLiteralTypes = true,
				compositeLiteralFields = true,
				functionTypeParameters = true,
			},
		},
	},
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = "workspace",
			useLibraryCodeForTypes = true,
		},
	},
	lua_ls = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

-- LSP border settings
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

-- LSP handlers
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Null-ls setup
local null_ls = require("null-ls")

local function setup_mason_null_ls()
	require("mason-null-ls").setup({
		ensure_installed = {
			-- formatters
			"stylua",
			"black",
			"isort",
			"goimports",
			"shfmt",
			"fixjson",
			-- linters
			"flake8",
			"tflint",
			"markdownlint",
			"sql_formatter", -- sql formatter
		},
		automatic_installation = true,
		automatic_setup = true,
	})
end
setup_mason_null_ls()

-- Null-ls handler setup
local function setup_mason_null_ls_handlers()
	require("mason-null-ls").setup_handlers({
		function(source_name, methods)
			require("mason-null-ls.automatic_setup")(source_name, methods)
		end,
		---@diagnostic disable-next-line: unused-local
		stylua = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.stylua.with({
				extra_args = {
					"--indent-type",
					"Tabs",
				},
			}))
		end,
		---@diagnostic disable-next-line: unused-local
		isort = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.isort)
		end,
		---@diagnostic disable-next-line: unused-local
		black = function(source_name, methods)
			null_ls.register(null_ls.builtins.formatting.black.with({
				extra_args = {
					"--fast",
				},
			}))
		end,
		---@diagnostic disable-next-line: unused-local
		flake8 = function(source_name, methods)
			null_ls.register(null_ls.builtins.diagnostics.flake8.with({
				extra_args = { "--max-line-length", "88", "--ignore", "E501,W503,E203" },
			}))
		end,
		---@diagnostic disable-next-line: unused-local
		markdownlint = function(source_name, methods)
			-- ignore ai-review buffer
			null_ls.register(null_ls.builtins.diagnostics.markdownlint.with({
				filetypes = { "markdown" },
				extra_args = { "--ignore", "MD013,MD033,MD041" },
			}))
		end,
	})
end
setup_mason_null_ls_handlers()

-- Null-ls formatting helper functions
local null_ls_formatting = function(bufnr)
	-- If the null_ls formatter is available, use it.
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local function is_null_ls_formatter_available(bufnr)
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		if client.name == "null-ls" and client.supports_method("textDocument/formatting") then
			return true
		end
	end
	return false
end

-- Create an autocommand group for formatting
local formatgroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Null-ls setup
local function setup_null_ls()
	null_ls.setup({
		on_attach = function(client, bufnr)
			-- If a null_ls formatter is available, it takes precedence over LSP.
			if client.supports_method("textDocument/formatting") == true then
				vim.api.nvim_clear_autocmds({ group = formatgroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = formatgroup,
					buffer = bufnr,
					callback = function()
						null_ls_formatting(bufnr)
					end,
				})
			end
		end,
	})
end
setup_null_ls()

-- LSP server setup helper functions
local function setup_server_handlers()
	mason_lspconfig.setup_handlers({
		function(server_name)
			local opts = {
				handlers = handlers,
			}

			local node_root_dir = nvim_lsp.util.root_pattern("package.json")
			local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil
			if server_name == "tsserver" then
				if not is_node_repo then
					return
				end

				opts.root_dir = node_root_dir
			elseif server_name == "eslint" then
				if not is_node_repo then
					return
				end

				opts.root_dir = node_root_dir
			elseif server_name == "denols" then
				if is_node_repo then
					return
				end

				opts.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
				opts.init_options = {
					lint = true,
					unstable = true,
					suggest = {
						imports = {
							hosts = {
								["https://deno.land"] = true,
								["https://cdn.nest.land"] = true,
								["https://crux.land"] = true,
							},
						},
					},
				}
			end

			opts.on_attach = function(client, bufnr)
				local bufopts = { replace_keycodes = false, noremap = true, silent = true, buffer = bufnr }
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
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)

				if is_null_ls_formatter_available(bufnr) then
					vim.keymap.set(
						"n",
						",f",
						null_ls_formatting,
						{ replace_keycodes = false, noremap = true, silent = true, buffer = bufnr }
					)
				else
					vim.keymap.set("n", ",f", vim.lsp.buf.format, bufopts)
				end

				local diagnosticConfig = {
					virtual_text = {
						prefix = "●",
						format = function(diagnostic)
							if diagnostic.code == nil then
								return string.format("[%s] %s", diagnostic.source, diagnostic.message)
							end
							return string.format("[%s: %s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
						end,
					},
				}
				vim.diagnostic.config(diagnosticConfig)
			end

			opts.capabilities = capabilities
			opts.settings = settings[server_name]
			nvim_lsp[server_name].setup(opts)
		end,
	})
end
setup_server_handlers()
