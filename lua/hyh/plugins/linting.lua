return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- 各种语言对应的 linter
		lint.linters_by_ft = {
			-- Web
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
			svelte = { "biomejs" },

			-- HTML
			html = { "htmlhint" },

			-- CSS
			css = { "stylelint" },
			scss = { "stylelint" },
			less = { "stylelint" },

			-- Python
			python = { "pylint" },

			-- C / C++
			c = { "clangtidy" },
			cpp = { "clangtidy" },
			h = { "clangtidy" },
			hpp = { "clangtidy" },

			-- Go
			go = { "golangcilint" },

			-- Rust
			rust = { "clippy" },
		}

		-- 自动触发检查
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- 手动触发快捷键
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Lint: 手动触发代码检查" })
	end,
}

