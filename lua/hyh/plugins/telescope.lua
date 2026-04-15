return {
	"nvim-telescope/telescope.nvim",
	-- 使用稳定版，无废弃警告（推荐）
	tag = "0.1.8",

	dependencies = {
		"nvim-lua/plenary.nvim",
		-- FZF 搜索加速（必须）
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			enabled = vim.fn.executable("make") == 1,
		},
		"nvim-tree/nvim-web-devicons", -- 图标
		"andrew-george/telescope-themes", -- 主题切换
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		-- 加载扩展
		telescope.load_extension("fzf")
		telescope.load_extension("themes")

		-- 核心配置（高性能 + 干净 UI）
		telescope.setup({
			defaults = {
				path_display = { "smart" }, -- 智能缩短路径
				file_ignore_patterns = { -- 忽略无关文件
					"node_modules",
					".git/",
					"target/",
					"vendor/",
					"__pycache__",
				},
				layout_strategy = "horizontal", -- 水平布局
				layout_config = {
					prompt_position = "top", -- 搜索框在上
					width = 0.85,
					height = 0.80,
					preview_cutoff = 120,
				},
				sorting_strategy = "ascending", -- 从上到下排序
				prompt_prefix = "🔍 ",
				selection_caret = " ",
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-c>"] = actions.close,
						["<CR>"] = actions.select_default,
					},
				},
			},

			-- 扩展：主题切换器
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})

		-- ===================== 快捷键 =======================
		-- 最近文件
		vim.keymap.set("n", "<leader>pr", builtin.oldfiles, { desc = "Telescope: Recent files" })

		-- 查找文件（最常用）
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope: Find files" })

		-- Git 文件（只显示 Git 管理的文件）
		vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Telescope: Git files" })

		-- 全局搜索内容
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Telescope: Search in project" })

		-- 搜索光标下的单词
		vim.keymap.set("n", "<leader>pWs", function()
			builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
		end, { desc = "Telescope: Search word under cursor" })

		-- 搜索缓冲区（已打开的文件）
		vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Telescope: Open buffers" })

		-- 主题切换
		vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>", { desc = "Telescope: Switch themes" })
	end,
}

