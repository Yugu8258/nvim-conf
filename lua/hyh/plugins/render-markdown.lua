return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	init = function()
		local fg = "#1F2335"
		local colors = {
			"#ff757f",
			"#4fd6be",
			"#7dcfff",
			"#ff9e64",
			"#7aa2f7",
			"#c0caf5",
		}

		for i, c in ipairs(colors) do
			vim.cmd(string.format("highlight Headline%dBg guifg=%s guibg=%s gui=bold", i, fg, c))
		end
	end,

	opts = {
		heading = {
			sign = false,
			icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
			backgrounds = {
				"Headline1Bg",
				"Headline2Bg",
				"Headline3Bg",
				"Headline4Bg",
				"Headline5Bg",
				"Headline6Bg",
			},
			foregrounds = {},
		},
		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},
		checkbox = {
			enabled = true,
			position = "inline",
			unchecked = { icon = "   󰄱 ", highlight = "RenderMarkdownUnchecked" },
			checked = { icon = "   󰱒 ", highlight = "RenderMarkdownChecked" },
		},
	},
}

