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

			-- 1. 执行格式化
			conform.format({
				bufnr = buf,
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})

			-- 2. 智能处理末尾空行（保留 1 行，不多不少）
			vim.schedule(function()
				local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
				if #lines == 0 then
					return
				end

				-- 删除末尾所有空行
				while #lines > 0 and lines[#lines] == "" do
					table.remove(lines)
				end

				-- 统一加 1 个空行（虚行）
				table.insert(lines, "")

				-- 写回缓冲区
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			end)
		end, { desc = "Format + 智能末尾空行" })
	end,
}

