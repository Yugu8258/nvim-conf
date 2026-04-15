return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		-- ========================
		-- LSP 快捷键
		-- ========================
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- 定义快捷键
				local map = function(mode, lhs, rhs, desc)
					opts.desc = desc
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
				map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
				map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
				map({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, "Code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
				map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics")
				map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
				map("n", "K", vim.lsp.buf.hover, "Documentation")
				map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")
				map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
			end,
		})

		-- ========================
		-- 诊断图标
		-- ========================
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		vim.diagnostic.config({
			signs = { text = signs },
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})

		-- ========================
		-- 全局能力
		-- ========================
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", { capabilities = capabilities })

		-- ========================
		-- LSP 服务配置
		-- ========================

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					workspace = { checkThirdParty = false },
				},
			},
		})

		-- Emmet（只启用一个，避免冲突）
		vim.lsp.config("emmet_language_server", {
			filetypes = { "css", "html", "javascriptreact", "less", "sass", "scss", "typescriptreact" },
		})

		-- TypeScript / JavaScript
		vim.lsp.config("ts_ls", {
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			single_file_support = true,
		})

		-- C / C++
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
				"--header-insertion=iwyu",
				"--enable-config",
				"--fallback-style=llvm",
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
		})

		-- Rust
		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					checkOnSave = { command = "clippy" },
					procMacro = { enable = true },
				},
			},
		})

		-- Go
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						unusedwrite = true,
						nilness = true,
						shadow = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		-- Zig
		vim.lsp.config("zls", {})

		-- CMake
		vim.lsp.config("cmake", {
			init_options = { buildDirectory = "build" },
		})

		-- ========================
		-- 启用所有 LSP
		-- ========================
		local servers = {
			"lua_ls",
			"emmet_language_server",
			"ts_ls",
			"clangd",
			"rust_analyzer",
			"gopls",
			"zls",
			"cmake",
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end
	end,
}

