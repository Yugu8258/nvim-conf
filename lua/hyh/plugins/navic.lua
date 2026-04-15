return {
	"SmiteshP/nvim-navic",
	lazy = false,
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local navic = require("nvim-navic")

		-- ========================
		-- 核心配置
		-- ========================
		navic.setup({
			icons = {
				File = " ",
				Module = " ",
				Namespace = " ",
				Package = " ",
				Class = " ",
				Method = " ",
				Property = " ",
				Field = " ",
				Constructor = " ",
				Enum = " ",
				Interface = " ",
				Function = " ",
				Variable = " ",
				Constant = " ",
				String = " ",
				Number = " ",
				Boolean = " ",
				Array = " ",
				Object = " ",
				Key = " ",
				Null = " ",
				EnumMember = " ",
				Struct = " ",
				Event = " ",
				Operator = " ",
				TypeParameter = " ",
			},
			separator = " > ",
			depth_limit = 0,
			depth_limit_indicator = "..",
			highlight = true,
		})

		-- ========================
		-- LSP 自动挂载
		-- ========================
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("Navic", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.documentSymbolProvider then
					navic.attach(client, args.buf)
				end
			end,
		})

		-- ========================
		-- 顶部 winbar 路径
		-- ========================
		vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

		-- ========================
		-- ROSE-PINE 透明配色
		-- ========================
		local function setup_navic_hl()
			vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE", fg = "#e0def4" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })

			-- Rose-Pine 配色
			vim.api.nvim_set_hl(0, "NavicIconsFile", { fg = "#9ccfd8" })
			vim.api.nvim_set_hl(0, "NavicIconsMethod", { fg = "#3e8fb0" })
			vim.api.nvim_set_hl(0, "NavicIconsFunction", { fg = "#3e8fb0" })
			vim.api.nvim_set_hl(0, "NavicIconsClass", { fg = "#f6c177" })
			vim.api.nvim_set_hl(0, "NavicIconsVariable", { fg = "#c4a7e7" })
			vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#6e6a86" })
		end

		setup_navic_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_navic_hl })
	end,
}

