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

		-- ==============================
		-- 格式化 + 末尾空行智能处理
		-- ==============================
		vim.keymap.set({ "n", "v" }, "<leader>w", function()
			local buf = vim.api.nvim_get_current_buf()
			local win = vim.api.nvim_get_current_win()
			local cursor = vim.api.nvim_win_get_cursor(win)

			-- 1. 执行格式化
			conform.format({
				bufnr = buf,
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})

			-- 2. 安全修复末尾空行
			local line_count = vim.api.nvim_buf_line_count(buf)
			while line_count > 0 do
				local last = vim.api.nvim_buf_get_lines(buf, line_count - 1, line_count, false)[1]
				if last == "" then
					vim.api.nvim_buf_set_lines(buf, line_count - 1, line_count, false, {})
					line_count = line_count - 1
				else
					break
				end
			end
			-- 确保最后只有 1 个空行
			vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "" })

			-- 3. 恢复光标，保证界面刷新
			vim.api.nvim_win_set_cursor(win, cursor)
			vim.cmd("redraw")

			-- 4. 保存
			vim.cmd("silent! write")
		end, { desc = "Format + 智能末尾空行" })
	end,
}

