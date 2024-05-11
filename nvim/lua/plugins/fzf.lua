return {
	-- fzf-luaプラグインをセットアップ
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- ファイルアイコンに必要
		},
		keys = {
			-- キーマッピング
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
			{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Open Recent File" },
			{ "<leader>fg", "<cmd>FzfLua live_grep_glob<cr>", desc = "Grep" },
			{ "<leader>fb", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep Current Buffer" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fc", "<cmd>FzfLua highlights<cr>", desc = "Color Highlights" },
			{ "<leader>fd", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>fD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
		},
		opts = function()
			local actions = require("fzf-lua.actions")
			return {
				-- fzf-luaのオプション設定
				fzf_opts = {
					["--layout"] = "reverse", -- 垂直レイアウト
					["--info"] = "inline", -- 情報を表示
					["--border"] = "rounded", -- 角丸ボーダー
					["--preview-window"] = "right:40%", -- プレビューウィンドウを右に配置、幅60%
				},
				winopts = {
					height = 0.85, -- ウィンドウの高さ
					width = 0.7, -- ウィンドウの幅
					preview = {
						vertical = "up:40%", -- プレビューを上に配置、高さ40%
					},
				},
				preview = {
					hidden = "toggle", -- プレビューを自動で表示/非表示
				},
				grep = {
					preview = "preview", -- プレビューを表示
				},
				-- ファイル選択時の動作設定
				actions = {
					files = {
						["default"] = actions.file_vsplit,
					},
					buffers = {
						["default"] = actions.buf_vsplit,
					},
				},
			}
		end,
	},
}
