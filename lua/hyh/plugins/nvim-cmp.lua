return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"nvim-treesitter/nvim-treesitter",
		"onsails/lspkind.nvim",
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local has_luasnip, luasnip = pcall(require, "luasnip")
		local lspkind = require("lspkind")
		local tailwind_formatter = require("tailwindcss-colorizer-cmp").formatter

		local function rhs(keys)
			return vim.api.nvim_replace_termcodes(keys, true, true, true)
		end

		local function column()
			local _, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col
		end

		local function in_leading_indent()
			local c = column()
			local p = vim.api.nvim_get_current_line():sub(1, c)
			return p:find("^%s*$") ~= nil
		end

		local function shift_width()
			return vim.o.softtabstop <= 0 and vim.fn.shiftwidth() or vim.o.softtabstop
		end

		local function smart_bs(dedent)
			local keys = ""
			if vim.o.expandtab then
				keys = dedent and rhs("<C-D>") or rhs("<BS>")
			else
				local p = vim.api.nvim_get_current_line():sub(1, column())
				if in_leading_indent() then
					keys = rhs("<BS>")
				else
					local prev = p:sub(#p, #p)
					keys = prev ~= " " and rhs("<BS>") or rhs("<C-\\><C-o>:set et<CR><BS><C-\\><C-o>:set noet<CR>")
				end
			end
			vim.api.nvim_feedkeys(keys, "nt", true)
		end

		local function smart_tab()
			local keys = ""
			if vim.o.expandtab then
				keys = rhs("<Tab>")
			else
				if in_leading_indent() then
					keys = rhs("<Tab>")
				else
					local sw = shift_width()
					local cur = vim.fn.virtcol(".")
					local rem = (cur - 1) % sw
					local move = rem == 0 and sw or sw - rem
					keys = rhs((" "):rep(move))
				end
			end
			vim.api.nvim_feedkeys(keys, "nt", true)
		end

		local function select_next(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end

		local function select_prev(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end

		-- 修复：未使用参数改为 _
		local function confirm(_)
			local behavior = cmp.ConfirmBehavior.Replace
			cmp.confirm({ select = true, behavior = behavior })
		end

		if has_luasnip then
			require("luasnip.loaders.from_vscode").lazy_load()
		end

		cmp.setup({
			experimental = { ghost_text = false },
			completion = { completeopt = "menu,menuone,noinsert" },

			window = {
				documentation = { border = "rounded" },
				completion = { border = "rounded" },
			},

			snippet = has_luasnip and {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			} or nil,

			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "lazydev" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "tailwindcss-colorizer-cmp" },
				{
					name = "spell",
					option = {
						enable_in_context = function()
							local ft = vim.bo.ft
							return ft == "markdown" or ft == "text"
						end,
					},
				},
			}),

			mapping = cmp.mapping.preset.insert({
				["<C-e>"] = cmp.mapping.abort(),
				["<C-d>"] = cmp.mapping.close_docs(),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping(select_next),
				["<C-k>"] = cmp.mapping(select_prev),
				["<C-n>"] = cmp.mapping(select_next),
				["<C-p>"] = cmp.mapping(select_prev),
				["<Down>"] = cmp.mapping(select_next),
				["<Up>"] = cmp.mapping(select_prev),

				["<C-y>"] = cmp.mapping(function(fb)
					if cmp.visible() then
						confirm(cmp.get_selected_entry())
					else
						fb()
					end
				end, { "i", "s" }),

				["<CR>"] = cmp.mapping(function(fb)
					if cmp.visible() then
						confirm(cmp.get_selected_entry())
					else
						fb()
					end
				end, { "i", "s" }),
			}),

			formatting = {
				fields = { "abbr", "menu", "kind" },
				maxwidth = 50,
				ellipsis_char = "...",

				format = function(entry, item)
					local icon = lspkind.symbolic(item.kind)
					item.kind = icon .. " " .. item.kind

					if entry.source.name == "nvim_lsp" then
						item = tailwind_formatter(entry, item)
					end

					item.menu = ({
						buffer = "[Buf]",
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						nvim_lua = "[Lua]",
					})[entry.source.name] or ""

					return item
				end,
			},
		})

		vim.keymap.set("i", "<Tab>", smart_tab, { silent = true })
		vim.keymap.set("i", "<S-Tab>", function() smart_bs(true) end, { silent = true })
	end,
}

