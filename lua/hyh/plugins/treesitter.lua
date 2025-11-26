return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },

				-- ensure these languages parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"yaml",
					"html",
					"css",
					"python",
					"http",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"c",
					"cpp",
					"java",
					"rust",
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
				additional_vim_regex_highlighting = false,
			})
		end,
	},
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			-- Independent nvim-ts-autotag setup
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- auto-close tags
					enable_rename = true, -- auto-rename pairs
					enable_close_on_slash = false, -- disable auto-close on trailing `</`
				},
				per_filetype = {
					["html"] = {
						enable_close = true, -- disable auto-closing for html
					},
					["typescriptreact"] = {
						enable_close = true, -- explicitly enable auto-closing (optional, defaults to `true`)
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Depends on the treesitter you already have installed
		event = "VeryLazy", -- Lazy load to avoid affecting startup speed
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable the sticky scroll feature
				max_lines = 5, -- Maximum number of context levels to show at the top (class → function → loop, avoid taking too much screen space)
				min_window_height = 0, -- No minimum window height restriction
				line_numbers = true, -- Do not show line numbers of the context (keep it clean, set to true if needed)
				multiline_threshold = 20, -- Only show context for blocks longer than 20 lines (avoid short blocks taking space)
				trim_scope = "outer", -- Trim outer scopes (only show key levels of the current context)
				mode = "cursor", -- Update context based on cursor position (more accurate)
				separator = "─", -- Separator between context levels (enhance visual distinction)
				highlight = "CursorLine", -- Highlight group for sticky context (reuse CursorLine color to avoid abruptness)
				zindex = 20, -- Layer priority (prevent being covered by other plugins)
			})

			-- Optional: Bind shortcut to toggle sticky scroll quickly (press <leader>tc to switch)
			vim.keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<CR>", {
				desc = "Toggle code structure sticky scroll",
				silent = true,
			})
		end,
	},
}

