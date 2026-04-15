return {
	-- 插件1：补全菜单里的 Tailwind 颜色预览
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		event = "VeryLazy",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})

			local cmp = require("cmp")
			local format = require("tailwindcss-colorizer-cmp").formatter

			cmp.setup({
				formatting = {
					format = function(entry, item)
						format(entry, item)
						return item
					end,
				},
			})
		end,
	},

	-- 插件2：代码里只高亮【字体颜色】，无背景
	{
		"NvChad/nvim-colorizer.lua",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
		config = function()
			require("colorizer").setup({
				filetypes = {
					"html",
					"css",
					"javascript",
					"typescript",
					"jsx",
					"tsx",
					"vue",
					"svelte",
				},
				user_default_options = {
					tailwind = true,
					mode = "foreground",  -- 关键：只染色字体
					RGB = true,
					RRGGBB = true,
					RRGGBBAA = true,
					names = false,
				},
			})
		end,
	},
}

