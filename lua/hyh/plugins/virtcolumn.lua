return {
	"lukas-reineke/virt-column.nvim",
	event = "VeryLazy",
	dependencies = {},
	config = function()
		local module_name = "virt-column"
		local ok, virt_column = pcall(require, module_name)

		if not ok then
			vim.notify(
				string.format(
					"virt-column.nvim failed to load! Reason: Module '%s' not found\nPlease run :Lazy install virt-column.nvim",
					module_name
				),
				vim.log.levels.ERROR
			)
			return
		end

		virt_column.setup({
			virtcolumn = "90",
			char = "│",
			exclude = {
				filetypes = { "alpha", "dashboard", "neo-tree", "toggleterm", "lazy", "mason" },
				buftypes = { "terminal", "quickfix", "help", "nofile" },
			},
		})
	end,
}

