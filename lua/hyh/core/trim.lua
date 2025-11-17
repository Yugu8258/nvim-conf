local function trim_and_preserve_eof()
	local buf = vim.api.nvim_get_current_buf()
	-- Get all lines from the current buffer (0-based index)
	local original_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local lines = vim.deepcopy(original_lines) -- Create a deep copy for modifications
	local last_line_idx = #lines -- Original line count (1-based numbering)

	-- Step 1: Clean trailing spaces and whitespace in empty lines
	for i = 1, last_line_idx do
		local line = lines[i]
		if line:match("%S") then
			-- Non-empty line: remove only trailing spaces
			lines[i] = line:gsub("%s+$", "")
		else
			-- Empty line (contains only spaces/tabs): clean to a pure empty line
			lines[i] = ""
		end
	end

	-- Step 2: Ensure there's exactly one empty line at the end of the file
	if last_line_idx == 0 then
		-- Empty file: add one empty line
		table.insert(lines, "")
	else
		-- Check if the last line is empty (after cleaning)
		local last_content = lines[last_line_idx]:gsub("%s+", "")
		if last_content ~= "" then
			-- Last line is non-empty: add one empty line
			table.insert(lines, "")
		else
			-- Last line is already empty: remove extra empty lines (keep only one)
			while #lines > 1 and lines[#lines - 1]:gsub("%s+", "") == "" do
				table.remove(lines, #lines - 1)
			end
		end
	end

	-- Key optimization: Only update changed lines to avoid full buffer refresh
	-- 1. Handle case where number of lines decreases (remove excess lines)
	if #lines < #original_lines then
		-- Delete extra lines starting from the new last line (0-based index)
		vim.api.nvim_buf_set_lines(buf, #lines, #original_lines, false, {})
	end

	-- 2. Compare line by line and update changed content
	for i = 1, math.min(#original_lines, #lines) do
		if lines[i] ~= original_lines[i] then
			-- Only update lines with changes (0-based index is i-1)
			vim.api.nvim_buf_set_lines(buf, i - 1, i, false, { lines[i] })
		end
	end

	-- 3. Handle case where number of lines increases (add new lines)
	if #lines > #original_lines then
		-- Add new lines after the original last line (0-based index)
		vim.api.nvim_buf_set_lines(
			buf,
			#original_lines,
			#original_lines,
			false,
			vim.list_slice(lines, #original_lines + 1, #lines)
		)
	end
end

-- Bind to pre-save event
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = trim_and_preserve_eof,
	desc = "Trim trailing spaces without full buffer refresh",
})

