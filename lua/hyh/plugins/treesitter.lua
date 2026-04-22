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
				auto_install = true, -- 自动安装缺失解析器（推荐开启）

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

	-- 自动闭合标签
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			})
		end,
	},

	-- 顶部 sticky 代码上下文
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

