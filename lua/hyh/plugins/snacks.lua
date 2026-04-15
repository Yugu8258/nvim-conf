return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			-- 缩进线配置（美观稳定）
			indent = {
				enabled = true,
				char = "│",
				context_char = "│",
				show_current_context = true,
				show_current_context_start = true,
				filetype_exclude = { "dashboard", "oil", "help", "terminal" },
				max_indent_level = 4,
			},

			-- 完全关闭所有其他模块，彻底避免 E36
			dashboard = { enabled = false },
			picker = { enabled = false },
			explorer = { enabled = false },
			layout = { enabled = false },
			win = { enabled = false },
			input = { enabled = false },
			quickfile = { enabled = false },
			image = { enabled = false },
			scroll = { enabled = false },
		},
	},
}

