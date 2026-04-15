return {
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "kevinhwang91/promise-async" },

		config = function()
			local ufo = require("ufo")

			ufo.setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 0,
			})

			-- 折叠基础配置
			vim.opt.foldenable = true
			vim.opt.foldcolumn = "0"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99

			-- 快捷键
			vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Ufo: 打开所有折叠" })
			vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Ufo: 关闭所有折叠" })
		end,
	},
}

