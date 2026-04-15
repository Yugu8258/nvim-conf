return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			strip_final_newline = false,
			trim_final_newlines = false,

			formatters = {
				["markdown-toc"] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find("<!%-%- toc %-%->") then
								return true
							end
						end
						return false
					end,
				},
				["markdownlint-cli2"] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
				clang_format = {
					args = {
						"--style=file",
						"--assume-filename",
						"$FILENAME",
					},
				},
				prettier = {
					args = {
						"--stdin-filepath",
						"$FILENAME",
						"--tab-width",
						"4",
						"--use-tabs",
						"false",
					},
				},
			},

			formatters_by_ft = {
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				css = { "biome" },
				html = { "biome" },
				svelte = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier", "markdown-toc" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				objc = { "clang_format" },
				objcpp = { "clang_format" },
				h = { "clang_format" },
				go = { "gofmt" },
			},
		})

		-- 格式化快捷键
		vim.keymap.set({ "n", "v" }, "<leader>w", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format document" })
	end,
}

