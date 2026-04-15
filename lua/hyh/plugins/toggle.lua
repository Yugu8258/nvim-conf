return {
	"rmagatti/alternate-toggler",
	event = "VeryLazy",

	config = function()
		require("alternate-toggler").setup({
			alternates = {
				["==="] = "!==",
				["=="] = "!=",
				["true"] = "false",
				["false"] = "true",
				["error"] = "warn",
				["warn"] = "error",
				["yes"] = "no",
				["on"] = "off",
				["left"] = "right",
				["top"] = "bottom",
				["enable"] = "disable",
			},
		})

		vim.keymap.set("n", "<leader>i", "<cmd>ToggleAlternate<CR>", {
			desc = "Toggle alternate word (true/false, ==/!=, etc)",
		})
	end,
}

