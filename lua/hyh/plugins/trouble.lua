return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	lazy = true,

	-- 增强 opts：更美观、更实用
	opts = {
		focus = true, -- 打开自动聚焦
		position = "bottom", -- 面板位置底部
		height = 12, -- 高度 12 行
		width = 50, -- 宽度
		icons = true, -- 启用图标
		use_diagnostic_signs = true, -- 使用内置诊断图标
	},

	-- 完整快捷键（原有的 + 新增跳转）
	keys = {
		-- 工作区诊断
		{ "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Workspace Diagnostics" },
		-- 当前文件诊断
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Document Diagnostics" },
		-- Quickfix 列表
		{ "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Trouble: Quickfix List" },
		-- 位置列表
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location List" },
		-- TODO 列表
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Trouble: Show TODOs" },

		-- =============================================
		-- 在 Trouble 里上下跳转到错误/TODO
		-- =============================================
		{
			"]x",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Trouble: Next diagnostic",
		},
		{
			"[x",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
			desc = "Trouble: Previous diagnostic",
		},
	},
}

