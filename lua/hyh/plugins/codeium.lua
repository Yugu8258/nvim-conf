return {
	{
		"Exafunction/codeium.vim",
		event = "InsertEnter",
		config = function()
			--  强制禁用 Codeium 所有默认按键(包括 Tab)
			vim.g.codeium_disable_bindings = 1

			-- 禁用 Tab 触发补全
			vim.g.codeium_no_map_tab = 1

			local keymap = vim.keymap.set

			-- 接受补全(仅 Ctrl+G)
			keymap("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true, desc = "Codeium: 接受补全" })

			-- 可选: 切换下一个补全
			keymap("i", "<C-n>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true, desc = "Codeium: 下一个补全" })

			-- 可选: 关闭当前补全
			keymap("i", "<C-c>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true, desc = "Codeium: 关闭补全" })
		end,
	},
}

