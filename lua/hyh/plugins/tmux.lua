return {
	"christoomey/vim-tmux-navigator",
	-- 延迟加载，不影响启动速度
	event = "VeryLazy",
	-- 快捷键：保持 Ctrl+hjkl 不变
	keys = {
		{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Jump to left window" },
		{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Jump to down window" },
		{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Jump to up window" },
		{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Jump to right window" },
		{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Jump to previous window" },
	},
	-- 官方推荐配置，避免冲突、增强兼容性
	config = function()
		vim.g.tmux_navigator_no_mappings = 1
		vim.g.tmux_navigator_disable_when_zoomed = 1
		vim.g.tmux_navigator_preserve_zoom = 1
	end,
}

