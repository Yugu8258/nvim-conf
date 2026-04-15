return {
	"lukas-reineke/virt-column.nvim", -- 代码长度标尺插件
	event = "VeryLazy", -- 延迟加载
	config = function()
		-- 安全加载插件
		local ok, virt_column = pcall(require, "virt-column")
		if not ok then
			vim.notify("插件加载失败", vim.log.levels.ERROR)
			return
		end

		virt_column.setup({
			virtcolumn = "120", -- 在第 120 列显示竖线
			char = "│", -- 竖线符号
			exclude = { -- 排除不显示的文件/窗口
				filetypes = { "alpha", "dashboard", "neo-tree", "toggleterm", "lazy", "mason" },
				buftypes = { "terminal", "quickfix", "help", "nofile" },
			},
		})
	end,
}

