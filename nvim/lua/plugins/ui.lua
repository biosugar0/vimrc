local is_loaded_plugin = require("rc.plugin_utils").is_loaded_plugin
local color = require("rc.color")
local diagnostic_icons = require("rc.font").diagnostic_icons
local todo_icons = require("rc.font").todo_icons
local enable_noice = require("rc.plugin_utils").enable_noice
local enable_lsp_lines = require("rc.plugin_utils").enable_lsp_lines
local get_lsp_lines_status = require("rc.plugin_utils").get_lsp_lines_status

return {
	{
		"nvim-lualine/lualine.nvim",
		event = { "FocusLost", "BufRead", "BufNewFile" },
		init = function()
			vim.api.nvim_create_user_command("LL", function()
				vim.cmd([[Lazy! load lualine.nvim]])
			end, {})
		end,
		config = function()
			local theme_table = function(theme)
				local table = {
					["gruvbox-material"] = function()
						local custom_gruvbox = require("lualine.themes.gruvbox-material")
						custom_gruvbox.normal.a.fg = color.base().black
						custom_gruvbox.normal.a.bg = color.base().blue
						custom_gruvbox.insert.a.fg = color.base().black
						custom_gruvbox.insert.a.bg = color.base().yellow
						custom_gruvbox.visual.a.fg = color.base().black
						custom_gruvbox.visual.a.bg = color.base().magenta
						custom_gruvbox.replace.a.fg = color.base().black
						custom_gruvbox.replace.a.bg = color.base().red
						return custom_gruvbox
					end,
					["catppuccin"] = function()
						return "catppuccin"
					end,
				}

				return table[theme] and table[theme]() or "auto"
			end

			local no_error = {
				function()
					if vim.env.LSP == "nvim" then
						local diagnostics = vim.diagnostic.get(0)
						local clients = vim.lsp.get_clients({ bufnr = 0 })

						if #diagnostics == 0 and #clients ~= 0 then
							return diagnostic_icons.success .. " "
						else
							return ""
						end
					end
				end,
				color = { fg = color.base().green },
			}

			local lsp_names = {
				function()
					local servers = vim.iter(vim.lsp.get_clients({ bufnr = 0 }))
						:map(function(server)
							if server.name ~= "null-ls" then
								return server.name
							end
						end)
						:totable()

					return table.concat(servers, ", ")
				end,
			}

			-- Displays the number of unsaved files other than the current buffer
			local function modified_buffers()
				local modified_background_buffers = vim.tbl_filter(function(bufnr)
					return vim.api.nvim_buf_is_valid(bufnr)
						and vim.api.nvim_buf_is_loaded(bufnr)
						and vim.api.nvim_buf_get_option(bufnr, "buftype") == ""
						and vim.api.nvim_buf_get_option(bufnr, "modifiable")
						and vim.api.nvim_buf_get_name(bufnr) ~= ""
						and vim.api.nvim_buf_get_number(bufnr) ~= vim.api.nvim_get_current_buf()
						and vim.api.nvim_buf_get_option(bufnr, "modified")
				end, vim.api.nvim_list_bufs())

				if #modified_background_buffers > 0 then
					return "!" .. #modified_background_buffers
				else
					return ""
				end
			end

			local function lsp_lines_mode()
				if vim.env.LSP ~= "nvim" or not enable_lsp_lines then
					return ""
				end

				local mode = ""
				if get_lsp_lines_status().mode == "current" then
					mode = "C"
				elseif get_lsp_lines_status().mode == "all" then
					mode = "A"
				elseif get_lsp_lines_status().mode == "none" then
					mode = "N"
				end

				return "LspLines: [" .. mode .. "]"
			end

			require("lualine").setup({
				options = {
					theme = theme_table(vim.env.NVIM_COLORSCHEME),
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = { { "filename", path = 1 }, modified_buffers },
					lualine_x = {
						no_error,
						{
							"diagnostics",
							symbols = {
								error = diagnostic_icons.error .. " ",
								warn = diagnostic_icons.warn .. " ",
								info = diagnostic_icons.info .. " ",
								hint = diagnostic_icons.hint .. " ",
							},
						},
						{ lsp_lines_mode },
						-- lsp_names,
						{ "filetype", colored = true, icon_only = false },
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				extensions = {
					"aerial",
					"fern",
					"fzf",
					"man",
					"quickfix",
					"toggleterm",
				},
			})
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		enabled = false,
		event = { "LspAttach" },
		config = function()
			require("dropbar").setup({
				icons = {
					kinds = {
						symbols = {
							Array = " ",
							Boolean = " ",
							BreakStatement = " ",
							Call = " ",
							CaseStatement = "󱃙 ",
							Class = " ",
							Color = " ",
							Constant = " ",
							Constructor = " ",
							ContinueStatement = " ",
							Copilot = " ",
							Declaration = " ",
							Delete = " ",
							DoStatement = " ",
							Enum = " ",
							EnumMember = " ",
							Event = " ",
							Field = " ",
							File = " ",
							Folder = " ",
							ForStatement = " ",
							Function = " ",
							Identifier = "󰀫 ",
							IfStatement = "󰇉 ",
							Interface = " ",
							Keyword = " ",
							List = " ",
							Log = "󰦪 ",
							Lsp = " ",
							Macro = "󰁌 ",
							MarkdownH1 = "󰉫 ",
							MarkdownH2 = "󰉬 ",
							MarkdownH3 = "󰉭 ",
							MarkdownH4 = "󰉮 ",
							MarkdownH5 = "󰉯 ",
							MarkdownH6 = "󰉰 ",
							Method = " ",
							Module = " ",
							Namespace = " ",
							Null = "󰢤 ",
							Number = "󰎠 ",
							Object = " ",
							Operator = " ",
							Package = " ",
							Property = " ",
							Reference = " ",
							Regex = " ",
							Repeat = " ",
							Scope = " ",
							Snippet = " ",
							Specifier = "󰦪 ",
							Statement = " ",
							String = " ",
							Struct = " ",
							SwitchStatement = "󰺟 ",
							Terminal = " ",
							Text = " ",
							Type = " ",
							TypeParameter = " ",
							Unit = " ",
							Value = " ",
							Variable = " ",
							WhileStatement = " ",
						},
					},
				},
			})
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		enabled = false,
		event = { "BufRead" },
		config = function()
			require("statuscol").setup({
				setopt = true,
			})
		end,
	},
	{
		"levouh/tint.nvim",
		enabled = false,
		event = { "BufRead" },
		config = function()
			require("tint").setup({
				highlight_ignore_patterns = {
					"@comment",
					"Comment",
					"WinSeparator",
					"VertSplit",
					"Status.*",
				},
				window_ignore_function = function(winid)
					local bufid = vim.api.nvim_win_get_buf(winid)
					local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
					local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

					return buftype == "terminal" or floating
				end,
			})
		end,
	},
	{
		"gen740/SmoothCursor.nvim",
		event = { "BufRead" },
		init = function()
			vim.api.nvim_create_autocmd({ "ColorScheme" }, {
				pattern = { "*" },
				callback = function()
					vim.api.nvim_set_hl(0, "SmoothCursor", { fg = color.base().blue, bg = "NONE" })
				end,
			})
		end,
		config = function()
			require("smoothcursor").setup({
				cursor = "", -- cursor shape (need nerd font)
				linehl = nil,
				priority = 10,
				disabled_filetypes = {
					"lazy",
					"aerial",
					"toggleterm",
				},
				fancy = {
					enable = true, -- enable fancy mode
					head = { cursor = "⊛", texthl = "SmoothCursorAqua", linehl = nil },
					body = {
						{ cursor = "⊛", texthl = "SmoothCursorAqua" },
						{ cursor = "⊛", texthl = "SmoothCursorAqua" },
						{ cursor = "•", texthl = "SmoothCursorAqua" },
						{ cursor = "•", texthl = "SmoothCursorAqua" },
						{ cursor = ".", texthl = "SmoothCursorAqua" },
						{ cursor = ".", texthl = "SmoothCursorAqua" },
					},
					tail = { cursor = nil, texthl = "SmoothCursorAqua" },
				},
				speed = 25, -- max is 100 to stick to your current position
				intervals = 35, -- tick interval
				priority = 10, -- set marker priority
				timeout = 3000,
				threshold = 3,
				texthl = "SmoothCursor",
				disable_float_win = true,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
		cmd = { "IndentBlanklineToggle" },
		init = function()
			vim.g.indent_blankline_enabled = false
			vim.keymap.set({ "n" }, "<Leader>i", "<Cmd>IndentBlanklineToggle!<CR>")
		end,
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost" },
		config = function()
			require("todo-comments").setup({
				keywords = {
					TODO = { icon = todo_icons.todo, color = color.base().green },
					FIX = { icon = todo_icons.fix, color = color.base().magenta, alt = { "FIXME", "BUG", "ISSUE" } },
					WARN = { icon = todo_icons.warn, color = color.base().orange, alt = { "WARNING" } },
					HACK = { icon = todo_icons.hack, color = color.base().orange },
					TEST = {
						icon = todo_icons.test,
						color = color.base().yellow,
						alt = { "TESTING", "PASSED", "FAILED" },
					},
					NOTE = {
						icon = todo_icons.note,
						color = color.base().blue,
						alt = { "Note", "INFO", "SEE", "See", "see" },
					},
					PREF = { icon = todo_icons.pref, color = color.base().cyan, alt = { "PERFORMANCE", "OPTIMIZE" } },
				},
			})

			vim.keymap.set({ "n" }, "tn", function()
				require("todo-comments").jump_next()
			end)
			vim.keymap.set({ "n" }, "tp", function()
				require("todo-comments").jump_prev()
			end)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		enabled = false,
		dependencies = {
			{ "kevinhwang91/promise-async" },
		},
		init = function()
			vim.api.nvim_create_autocmd({ "ColorScheme" }, {
				pattern = { "*" },
				callback = function()
					vim.api.nvim_set_hl(0, "UfoFoldVirtText", { fg = color.base().blue })
				end,
			})
		end,
		config = function()
			local enable_file_type = { "typescript", "typescriptreact", "vim", "lua" }

			local function ufo_width()
				local width = 0
				for winnr = 1, vim.fn.winnr("$") do
					local win_width = vim.api.nvim_win_get_width(vim.fn.win_getid(winnr))
					width = win_width > width and win_width or width
				end
				return width
			end

			require("ufo").setup({
				open_fold_hl_timeout = 0,
				provider_selector = function(_, filetype, _)
					if vim.tbl_contains(enable_file_type, filetype) then
						return { "treesitter", "indent" }
					end

					return ""
				end,
				preview = {
					win_config = {
						winhighlight = "Normal:Normal,FloatBorder:Normal",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
					},
				},
				enable_fold_and_virt_text = true,
				fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
					local new_virt_text = {}
					local suffix = (" ↲ %d "):format(end_lnum - lnum)
					local suf_width = vim.fn.strdisplaywidth(suffix)
					local target_width = width - suf_width
					local cur_width = 0

					for _, chunk in ipairs(virt_text) do
						local chunk_text = chunk[1]
						local chunk_width = vim.fn.strdisplaywidth(chunk_text)
						if target_width > cur_width + chunk_width then
							table.insert(new_virt_text, chunk)
						else
							chunk_text = truncate(chunk_text, target_width - cur_width)
							local hl_group = chunk[2]
							table.insert(new_virt_text, { chunk_text, hl_group })
							chunk_width = vim.fn.strdisplaywidth(chunk_text)
							if cur_width + chunk_width < target_width then
								suffix = suffix .. ("."):rep(target_width - cur_width - chunk_width)
							end
							break
						end
						cur_width = cur_width + chunk_width
					end

					table.insert(new_virt_text, { suffix, "UfoFoldVirtText" })
					table.insert(new_virt_text, { ("."):rep(ufo_width()), "Comment" })
					return new_virt_text
				end,
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		cmd = { "AerialToggle" },
		init = function()
			vim.keymap.set({ "n" }, "<Leader>a", "<Cmd>AerialToggle!<CR>")
			vim.keymap.set({ "n" }, "<Leader>A", "<Cmd>AerialToggle<CR>")
		end,
		config = function()
			require("aerial").setup({
				backends = { "treesitter", "markdown" },
				filter_kind = {
					"Class",
					"Constructor",
					"Enum",
					"Function",
					"Interface",
					"Module",
					"Method",
					"Struct",
					"Variable",
				},
				layout = {
					win_opts = {
						winblend = 10,
					},
					default_direction = "float",
					placement = "edge",
				},
				float = {
					border = "rounded",
					relative = "win",
					max_height = 0.9,
					height = nil,
					min_height = { 8, 0.1 },

					override = function(conf, source_winid)
						conf.anchor = "NE"
						conf.col = vim.fn.winwidth(source_winid)
						conf.row = 0
						return conf
					end,
				},
			})
		end,
	},
	{
		"folke/noice.nvim",
		enabled = enable_noice,
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{ "rcarriga/nvim-notify" },
		},
		event = { "VeryLazy" },
		config = function()
			require("noice").setup({
				lsp = {
					signature = {
						enabled = false,
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				presets = {
					command_palette = true,
					long_message_to_split = true,
				},
			})
		end,
	},
	{ "ryanoasis/vim-devicons" },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local red = color.base().red
			local green = color.base().green
			local yellow = color.base().yellow
			local blue = color.base().blue
			local magenta = color.base().magenta
			local cyan = color.base().cyan
			local white = color.base().white

			require("nvim-web-devicons").set_default_icon("󾩻 ", white)
			require("nvim-web-devicons").setup({
				override = {
					[".babelrc"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Babelrc",
					},
					[".gitignore"] = {
						icon = " ",
						color = white,
						cterm_color = "59",
						name = "GitIgnore",
					},
					[".vimrc"] = {
						icon = " ",
						color = green,
						cterm_color = "29",
						name = "Vimrc",
					},
					[".zshenv"] = {
						icon = " ",
						color = white,
						cterm_color = "113",
						name = "Zshenv",
					},
					[".zshrc"] = {
						icon = " ",
						color = white,
						cterm_color = "113",
						name = "Zshrc",
					},
					["Brewfile"] = {
						icon = " ",
						color = green,
						cterm_color = "113",
						name = "Brewfile",
					},
					["COMMIT_EDITMSG"] = {
						icon = " ",
						color = white,
						cterm_color = "59",
						name = "GitCommit",
					},
					["Dockerfile"] = {
						icon = " ",
						color = white,
						cterm_color = "59",
						name = "Dockerfile",
					},
					["Gemfile$"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "Gemfile",
					},
					["LICENSE"] = {
						icon = " ",
						color = white,
						cterm_color = "179",
						name = "License",
					},
					["ai"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Ai",
					},
					["bash"] = {
						icon = " ",
						color = green,
						cterm_color = "113",
						name = "Bash",
					},
					["bmp"] = {
						icon = " ",
						color = cyan,
						cterm_color = "140",
						name = "Bmp",
					},
					["coffee"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Coffee",
					},
					["conf"] = {
						icon = " ",
						color = white,
						cterm_color = "66",
						name = "Conf",
					},
					["config.ru"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "ConfigRu",
					},
					["css"] = {
						icon = " ",
						color = blue,
						cterm_color = "39",
						name = "Css",
					},
					["csv"] = {
						icon = " ",
						color = blue,
						cterm_color = "113",
						name = "Csv",
					},
					["diff"] = {
						icon = " ",
						color = white,
						cterm_color = "59",
						name = "Diff",
					},
					["doc"] = {
						icon = "  ",
						color = blue,
						cterm_color = "25",
						name = "Doc",
					},
					["dockerfile"] = {
						icon = " ",
						color = white,
						cterm_color = "59",
						name = "Dockerfile",
					},
					["ejs"] = {
						icon = "�� ",
						color = yellow,
						cterm_color = "185",
						name = "Ejs",
					},
					["erb"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "Erb",
					},
					["favicon.ico"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Favicon",
					},
					["gemspec"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "Gemspec",
					},
					["gif"] = {
						icon = " ",
						color = cyan,
						cterm_color = "140",
						name = "Gif",
					},
					["git"] = {
						icon = " ",
						color = magenta,
						cterm_color = "202",
						name = "GitLogo",
					},
					["go"] = {
						icon = " ",
						color = blue,
						cterm_color = "67",
						name = "Go",
					},
					["graphql"] = {
						icon = " ",
						color = magenta,
						cterm_color = "202",
						name = "GraphQL",
					},
					["htm"] = {
						icon = " ",
						color = magenta,
						cterm_color = "166",
						name = "Htm",
					},
					["html"] = {
						icon = " ",
						color = magenta,
						cterm_color = "202",
						name = "Html",
					},
					["ico"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Ico",
					},
					["ini"] = {
						icon = " ",
						color = white,
						cterm_color = "66",
						name = "Ini",
					},
					["jpeg"] = {
						icon = "  ",
						color = cyan,
						cterm_color = "140",
						name = "Jpeg",
					},
					["jpg"] = {
						icon = " ",
						color = cyan,
						cterm_color = "140",
						name = "Jpg",
					},
					["js"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Js",
					},
					["json"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "Json",
					},
					["jsx"] = {
						icon = " ",
						color = blue,
						cterm_color = "67",
						name = "Jsx",
					},
					["license"] = {
						icon = " ",
						color = yellow,
						cterm_color = "185",
						name = "License",
					},
					["lua"] = {
						icon = " ",
						color = blue,
						cterm_color = "74",
						name = "Lua",
					},
					["makefile"] = {
						icon = " ",
						color = white,
						cterm_color = "66",
						name = "Makefile",
					},
					["markdown"] = {
						icon = " ",
						color = yellow,
						cterm_color = "67",
						name = "Markdown",
					},
					["md"] = {
						icon = " ",
						color = yellow,
						cterm_color = "67",
						name = "Markdown",
					},
					["mdx"] = {
						icon = " ",
						color = yellow,
						cterm_color = "67",
						name = "Mdx",
					},
					["mjs"] = {
						icon = " ",
						color = yellow,
						cterm_color = "221",
						name = "Mjs",
					},
					["node_modules"] = {
						icon = " ",
						color = yellow,
						cterm_color = "161",
						name = "NodeModules",
					},
					["package.json"] = {
						icon = " ",
						color = yellow,
						name = "PackageJson",
					},
					["package-lock.json"] = {
						icon = " ",
						color = yellow,
						name = "PackageLockJson",
					},
					["pdf"] = {
						icon = "  ",
						color = red,
						cterm_color = "124",
						name = "Pdf",
					},
					["png"] = {
						icon = " ",
						color = cyan,
						cterm_color = "140",
						name = "Png",
					},
					["psd"] = {
						icon = " ",
						color = blue,
						cterm_color = "67",
						name = "Psd",
					},
					["py"] = {
						icon = "",
						color = yellow,
						cterm_color = "61",
						name = "Py",
					},
					["rake"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "Rake",
					},
					["Rakefile"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "Rakefile",
					},
					["rb"] = {
						icon = " ",
						color = red,
						cterm_color = "52",
						name = "Rb",
					},
					["rs"] = {
						icon = " ",
						color = white,
						cterm_color = "180",
						name = "Rs",
					},
					["scss"] = {
						icon = " ",
						color = magenta,
						cterm_color = "204",
						name = "Scss",
					},
					["sh"] = {
						icon = " ",
						color = white,
						cterm_color = "59",
						name = "Sh",
					},
					["sql"] = {
						icon = " ",
						color = white,
						cterm_color = "188",
						name = "Sql",
					},
					["sqlite"] = {
						icon = " ",
						color = white,
						cterm_color = "188",
						name = "Sql",
					},
					["svg"] = {
						icon = " ",
						color = yellow,
						cterm_color = "215",
						name = "Svg",
					},
					["tex"] = {
						icon = "ﭨ ",
						color = green,
						cterm_color = "58",
						name = "Tex",
					},
					["toml"] = {
						icon = " ",
						color = white,
						cterm_color = "66",
						name = "Toml",
					},
					["ts"] = {
						icon = " ",
						color = blue,
						cterm_color = "67",
						name = "Ts",
					},
					["tsx"] = {
						icon = " ",
						color = blue,
						cterm_color = "67",
						name = "Tsx",
					},
					["txt"] = {
						icon = "󾩻 ",
						color = green,
						cterm_color = "113",
						name = "Txt",
					},
					["vim"] = {
						icon = " ",
						color = green,
						cterm_color = "29",
						name = "Vim",
					},
					["vue"] = {
						icon = "  ",
						color = green,
						cterm_color = "107",
						name = "Vue",
					},
					["webp"] = {
						icon = " ",
						color = cyan,
						cterm_color = "140",
						name = "Webp",
					},
					["xml"] = {
						icon = " ",
						color = yellow,
						cterm_color = "173",
						name = "Xml",
					},
					["yaml"] = {
						icon = " ",
						color = white,
						cterm_color = "66",
						name = "Yaml",
					},
					["yml"] = {
						icon = " ",
						color = white,
						cterm_color = "66",
						name = "Yml",
					},
					["zsh"] = {
						icon = " ",
						color = green,
						cterm_color = "113",
						name = "Zsh",
					},
					[".env"] = {
						icon = " ",
						color = yellow,
						cterm_color = "226",
						name = "Env",
					},
					["prisma"] = {
						icon = " ",
						color = white,
						cterm_color = "white",
						name = "Prisma",
					},
				},
			})
		end,
	},
}
