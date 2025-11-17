return {
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
		end,
	},
}

