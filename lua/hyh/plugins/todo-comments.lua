return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local todo = require("todo-comments")

		todo.setup({
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = {
					icon = " ",
					color = "info",
					alt = { "Personal" },
				},
				HACK = {
					icon = " ",
					color = "warning",
					alt = { "DON SKIP" },
				},
				WARN = {
					icon = " ",
					color = "warning",
					alt = { "WARNING", "XXX" },
				},
				PERF = {
					icon = " ",
					alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
				},
				NOTE = {
					icon = " ",
					color = "hint",
					alt = { "INFO", "READ", "COLORS", "Custom" },
				},
				TEST = {
					icon = "⏲ ",
					color = "test",
					alt = { "TESTING", "PASSED", "FAILED" },
				},
				FORGETNOT = {
					icon = " ",
					color = "hint",
				},
			},

			-- 优化：只高亮字体颜色，无背景、无高亮块
			highlight = {
				multiline = false,
				keyword = "fg",         -- 只给文字上色
				before = "",            -- 前面不高亮
				after = "",             -- 后面不高亮
				comments_only = false,

				pattern = {
					[[.*<(KEYWORDS)\s*:]],
					[[<!--\s*(KEYWORDS)\s*:.*-->]],
					[[<!--\s*(KEYWORDS)\s*.*-->]],
				},
			},

			search = {
				command = "rg",
				pattern = [[\b(KEYWORDS)\b]],
			},

			-- 柔和文字颜色（不刺眼、只染色文字）
			colors = {
				error = { "#ff5555" },   -- 红
				warning = { "#ffb347" }, -- 黄
				info = { "#5fa8ff" },    -- 蓝
				hint = { "#50fa7b" },    -- 绿
				test = { "#bd93f9" },    -- 紫
			},
		})

		-- 快捷键
		vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next TODO" })
		vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous TODO" })
		vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find ALL TODO comments" })
		vim.keymap.set("n", "<leader>ftl", "<cmd>TodoLocList<cr>", { desc = "Show TODO loclist" })
		vim.keymap.set("n", "<leader>fts", "<cmd>TodoTrouble<cr>", { desc = "TODO in Trouble panel" })
	end,
}

