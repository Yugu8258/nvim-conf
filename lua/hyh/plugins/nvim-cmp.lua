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

		local function in_snippet()
			if not has_luasnip then
				return false
			end
			local session = luasnip.session
			local node = session.current_nodes[vim.api.nvim_get_current_buf()]
			if not node then
				return false
			end
			local snip = node.parent.snippet
			local beg, _end = snip.mark:pos_begin_end()
			local pos = vim.api.nvim_win_get_cursor(0)
			return pos[1] - 1 >= beg[1] and pos[1] - 1 <= _end[1]
		end

		local function in_whitespace()
			local col = column()
			return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")
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

		local function confirm(entry)
			local behavior = cmp.ConfirmBehavior.Replace
			if
				entry
				and entry.context.cursor_after_line:sub(
						1,
						math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col
					)
					~= (
						entry.completion_item.textEdit and entry.completion_item.textEdit.newText
						or entry.completion_item.insertText
						or entry.completion_item.word
						or entry.completion_item.label
						or ""
					):sub(-math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col)
			then
				behavior = cmp.ConfirmBehavior.Insert
			end
			cmp.confirm({ select = true, behavior = behavior })
		end

		if has_luasnip then
			require("luasnip.loaders.from_vscode").lazy_load()
		end

		cmp.setup({
			experimental = { ghost_text = false },
			completion = { completeopt = "menu,menuone,noinsert" },

			window = {
				documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
				completion = { border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" } },
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

				["<S-Tab>"] = cmp.mapping(function(fb)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif has_luasnip and in_snippet() and luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif in_leading_indent() then
						smart_bs(true)
					elseif in_whitespace() then
						smart_bs()
					else
						fb()
					end
				end, { "i", "s" }),

				["<Tab>"] = cmp.mapping(function(_)
					if cmp.visible() then
						local entries = cmp.get_entries()
						if #entries == 1 then
							confirm(entries[1])
						else
							cmp.select_next_item()
						end
					elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif in_whitespace() then
						smart_tab()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
			}),

			formatting = {
				format = function(entry, item)
					item = lspkind.cmp_format({
						maxwidth = 25,
						ellipsis_char = "...",
					})(entry, item)

					if entry.source.name == "nvim_lsp" then
						item = tailwind_formatter(entry, item)
					end

					item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
					})[entry.source.name]

					return item
				end,
			},
		})
	end,
}

