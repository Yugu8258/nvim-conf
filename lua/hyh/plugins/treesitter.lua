return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				sync_install = false,
				ignore_install = {},
				auto_install = true,

				highlight = { enable = true },
				indent = { enable = true },
				additional_vim_regex_highlighting = false,

				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"dockerfile",
					"gitignore",
					"go",
					"graphql",
					"html",
					"java",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"query",
					"rust",
					"svelte",
					"typescript",
					"tsx",
					"vim",
					"vimdoc",
					"yaml",
					"zig",
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},

				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["if"] = "@function.inner",
							["af"] = "@function.outer",
							["ic"] = "@class.inner",
							["ac"] = "@class.outer",
							["ib"] = "@block.inner",
							["ab"] = "@block.outer",
						},
					},
				},
			})
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		main = "nvim-ts-autotag",
		opts = {},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		opts = {
			enable = true,
			max_lines = 5,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			separator = "─",
			zindex = 20,
		},
	},
}

