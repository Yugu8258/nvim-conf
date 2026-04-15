return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},

	-- 快捷键（保持你原来的）
	keys = {
		{ "<leader>sN", "<CMD>Noice pick<CR>", desc = "[Noice] 查看消息历史" },
		{ "<leader>N", "<CMD>Noice<CR>", desc = "[Noice] 打开Noice面板" },
	},

	-- 优化后配置：干净、不打扰、美观
	opts = {
		-- 关闭不需要的模块
		popupmenu = { enabled = false },
		notify = { enabled = false },

		-- LSP UI 优化（推荐开启，文档更美观）
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
			signature = { enabled = true },
			hover = { enabled = true },
		},

		-- 预设配置
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true, -- LSP 提示带边框
		},

		-- 屏蔽烦人的消息（核心优化）
		routes = {
			{ filter = { event = "lsp" }, opts = { skip = true } },
			-- 屏蔽搜索计数
			{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
			-- 屏蔽 "written" / "Yanked" / 文件保存消息
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = "%d+ lines yanked" },
						{ find = "Already at oldest change" },
						{ find = "Already at newest change" },
					},
				},
				opts = { skip = true },
			},
		},

		-- 命令行界面更干净
		cmdline = {
			enabled = true,
			format = {
				cmdline = { icon = " " },
				search_down = { icon = " " },
				search_up = { icon = " " },
				filter = { icon = "" },
				lua = { icon = " " },
			},
		},
	},
}

