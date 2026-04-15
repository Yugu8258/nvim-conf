return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	lazy = true,

	opts = {
		focus = true,
		position = "bottom",
		height = 12,
		width = 50,
		icons = true,
		use_diagnostic_signs = true,
	},

	keys = {
		-- 诊断
		{ "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Workspace Diagnostics" },
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Document Diagnostics" },
		{ "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Trouble: Quickfix List" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location List" },
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Trouble: Show TODOs" },

		{ "]x", "<cmd>Trouble next<cr>", desc = "Trouble: Next diagnostic" },
		{ "[x", "<cmd>Trouble prev<cr>", desc = "Trouble: Previous diagnostic" },
	},
}

