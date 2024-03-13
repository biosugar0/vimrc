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
			"gopls",
			"lua_ls",
			"sqlls",
			"terraformls",
			"tsserver",
			"yamlls",
			"pyright",
			"ruff_lsp",
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
	pyright = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				autoImportCompletions = false,
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				logLevel = "Warning",
				-- These diagnostics are useless, therefore disable them.
				diagnosticSeverityOverrides = {
					reportArgumentType = "none",
					reportAttributeAccessIssue = "none",
					reportCallIssue = "none",
					reportFunctionMemberAccess = "none",
					reportGeneralTypeIssues = "none",
					reportIncompatibleMethodOverride = "none",
					reportIncompatibleVariableOverride = "none",
					reportIndexIssue = "none",
					reportOptionalMemberAccess = "none",
					reportOptionalSubscript = "none",
					reportPrivateImportUsage = "none",
				},
				indexing = true,
				inlayHints = {
					functionReturnTypes = true,
					variableTypes = true,
				},
				typeCheckingMode = "off",
				useLibraryCodeForTypes = true,
			},
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

require("mason-null-ls").setup({
	ensure_installed = {
		-- formatters
		"stylua",
		"goimports",
		"shfmt",
		"fixjson",
		-- linters
		"tflint",
		"markdownlint",
		"sql_formatter", -- sql formatter
		"golangci-lint",
	},
	automatic_installation = true,
	handlers = {
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
		markdownlint = function(source_name, methods)
			-- ignore ai-review buffer
			null_ls.register(null_ls.builtins.diagnostics.markdownlint.with({
				filetypes = { "markdown" },
				extra_args = { "--ignore", "MD013,MD033,MD041" },
			}))
		end,
		--@diagnostic disable-next-line: unused-local
		["golangci-lint"] = function(source_name, methods)
			null_ls.register(null_ls.builtins.diagnostics.golangci_lint.with({
				filetypes = { "go" },
				extra_args = {
					"run",
					"--fix=false",
					"--out-format=json",
					"--enable-all",
					"--allow-parallel-runners",
				},
			}))
		end,
	},
})
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

			-- 共通のcapabilities設定
			local cap = vim.lsp.protocol.make_client_capabilities()
			-- 共通のon_attach関数を定義
			local function on_attach_common(client, bufnr)
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

			local node_root_dir = nvim_lsp.util.root_pattern("package.json")
			local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil
			if server_name == "tsserver" or server_name == "eslint" then
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
			elseif server_name == "pyright" then
				-- Pyright固有の設定
				-- lintingをRuffに任せる
				cap.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
			elseif server_name == "ruff_lsp" then
				-- Ruff LSP固有の設定
				opts.on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
					-- Ruff LSP固有の設定をここに記述
					client.server_capabilities.hoverProvider = true
					local ruff_lsp_client = require("lspconfig.util").get_active_client_by_name(bufnr, "ruff_lsp")
					local request = function(method, params)
						ruff_lsp_client.request(method, params, nil, bufnr)
					end

					local organize_imports = function()
						request("workspace/executeCommand", {
							command = "ruff.applyOrganizeImports",
							arguments = {
								{ uri = vim.uri_from_bufnr(bufnr) },
							},
						})
					end

					vim.api.nvim_create_user_command(
						"RuffOrganizeImports",
						organize_imports,
						{ desc = "Ruff: Organize Imports" }
					)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.cmd("RuffOrganizeImports")
						end,
					})
				end
			end

			-- 共通のon_attachを設定
			if not opts.on_attach then
				opts.on_attach = on_attach_common
			end

			-- 共通のcapabilitiesを設定
			opts.capabilities = cap
			opts.settings = settings[server_name]
			nvim_lsp[server_name].setup(opts)
		end,
	})
end
setup_server_handlers()
