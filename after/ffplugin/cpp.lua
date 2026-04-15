if vim.b.did_my_ftplugin then
	return
end
vim.b.did_my_ftplugin = true

-- 切换源文件/头文件 (Clangd 专属)
local function switch_source_header(bufnr, client)
	local method = "textDocument/switchSourceHeader"
	if not client:supports_method(method) then
		vim.notify("Clangd does not support switchSourceHeader", vim.log.levels.ERROR)
		return
	end

	local params = vim.lsp.util.make_text_document_params(bufnr)
	client:request(method, params, function(err, result)
		if err then error(err) end
		if not result then
			vim.notify("No corresponding file found")
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

-- 显示符号信息
local function symbol_info(bufnr, client)
	local method = "textDocument/symbolInfo"
	if not client:supports_method(method) then
		vim.notify("Clangd does not support symbolInfo", vim.log.levels.ERROR)
		return
	end

	local winid = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params(winid, client.offset_encoding)
	client:request(method, params, function(err, res)
		if err or not res or #res == 0 then return end

		local lines = {
			"name: " .. res[1].name,
			"container: " .. res[1].containerName,
		}
		local max_width = math.max(vim.fn.strdisplaywidth(lines[1]), vim.fn.strdisplaywidth(lines[2]))

		vim.lsp.util.open_floating_preview(lines, "", {
			height = 2,
			width = max_width,
			focusable = false,
			title = "Symbol Info",
		})
	end, bufnr)
end

-- Clangd LSP 配置
vim.lsp.config("clangd", {
	cmd = { "clangd", "-j=2", "--background-index=false", "--header-insertion=never" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
	capabilities = {
		textDocument = {
			completion = { editsNearCursor = true },
		},
		offsetEncoding = { "utf-8", "utf-16" },
	},
	on_init = function(client, init_result)
		if init_result.offsetEncoding then
			client.offset_encoding = init_result.offsetEncoding
		end
	end,
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
			switch_source_header(bufnr, client)
		end, { desc = "Clangd: Switch between source and header" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
			symbol_info(bufnr, client)
		end, { desc = "Clangd: Show symbol info" })
	end,
})

-- 格式化快捷键 (正常模式 + 可视化模式)
if vim.fn.executable("lcg-clang-format-8.0.0") == 1 then
	vim.keymap.set("n", "<leader>w", "<cmd>silent !lcg-clang-format-8.0.0 %<CR>", { desc = "Format file (lcg-clang-format)" })
else
	vim.keymap.set("v", "<leader>w", ":<C-U>%!clang-format<CR>gv", { desc = "Format selection (clang-format)" })
end

