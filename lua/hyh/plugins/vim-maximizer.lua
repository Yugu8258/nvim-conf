return {
	"szw/vim-maximizer",
	keys = {
		{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize window" },
	},
	config = function()
		-- 保持终端大小正确（解决部分终端缩放问题）
		vim.g.maximizer_restore_on_winleave = 1
	end,
}

