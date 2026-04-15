return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	priority = 1000,

	config = function()
		local lualine = require("lualine")

		-- ==============================================
		-- 🔥 修复：系统图标识别（100% 准确版本）
		-- ==============================================
		local os_name = vim.loop.os_uname().sysname
		local os_icon = "" --  fallback

		-- macOS
		if os_name == "Darwin" then
			os_icon = ""
		-- Windows
		elseif os_name == "Windows_NT" then
			os_icon = ""
		-- Linux 发行版（更稳定的识别方式）
		elseif os_name == "Linux" then
			local distro = vim.trim(vim.fn.system([[grep "^ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"']]))
			if distro == "ubuntu" or distro == "pop" then
				os_icon = ""
			elseif distro == "arch" then
				os_icon = ""
			elseif distro == "kali" then
				os_icon = ""
			else
				os_icon = ""
			end
		end

		-- ====================== ROSE-PINE 透明主题
		local rose_theme = {
			normal = {
				a = { fg = "#e0def4", bg = "NONE", gui = "bold" },
				b = { fg = "#9ccfd8", bg = "NONE" },
				c = { fg = "#6e6a86", bg = "NONE" },
				x = { fg = "#6e6a86", bg = "NONE" },
				y = { fg = "#ebbcba", bg = "NONE" },
				z = { fg = "#c4a7e7", bg = "NONE", gui = "bold" },
			},
			insert = { a = { fg = "#9ccfd8", bg = "NONE", gui = "bold" } },
			visual = { a = { fg = "#c4a7e7", bg = "NONE", gui = "bold" } },
			replace = { a = { fg = "#eb6f92", bg = "NONE", gui = "bold" } },
			command = { a = { fg = "#f6c177", bg = "NONE", gui = "bold" } },
			inactive = {
				a = { fg = "#6e6a86", bg = "NONE" },
				b = { fg = "#6e6a86", bg = "NONE" },
				c = { fg = "#6e6a86", bg = "NONE" },
			},
		}

		-- 强制透明
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
				vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
			end,
		})

		vim.schedule(function()
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
		end)

		-- ====================== 最终配置
		lualine.setup({
			options = {
				theme = rose_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = {
					{
						os_icon,
						color = { fg = "#ebbcba" },
						separator = { right = "" },
					},
					"progress",
				},
				lualine_z = { "location" },
			},
			extensions = { "nvim-tree", "toggleterm" },
		})
	end,
}

