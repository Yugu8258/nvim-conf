return {
	"mbbill/undotree",
	event = "VeryLazy", -- 延迟加载，不影响启动速度
	config = function()
		vim.g.undotree_DiffAutoOpen = 0 -- 关闭自动打开diff面板
		vim.g.undotree_SetFocusWhenToggle = 1 -- 打开后自动聚焦到 undotree
		vim.g.undotree_ShortIndicators = 1 -- 使用简短指示器
		vim.g.undotree_WindowLayout = 2 -- 右侧布局（更美观）

		-- 快捷键
		vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", {
			desc = "Toggle Undo Tree (edit history)",
		})
	end,
}

