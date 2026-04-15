return {
	"nguyenvukhang/nvim-toggler",
	lazy = false,

	config = function()
		local toggler = require("nvim-toggler")

		toggler.setup({
			inverses = {
				["==="] = "!==",
				["=="] = "!=",
				["true"] = "false",
				["error"] = "warn",
				["yes"] = "no",
				["on"] = "off",
				["left"] = "right",
				["top"] = "bottom",
				["enable"] = "disable",
			},
		})

		vim.keymap.set("n", "<leader>i", function()
			require("nvim-toggler").toggle()
		end, {
			noremap = true,
			silent = true,
			desc = "Toggle alternate word",
		})
	end,
}

