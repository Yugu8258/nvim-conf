-- Trims trailing whitespace, cleans empty lines, and ensures a single trailing newline at EOF
local function trim_and_preserve_eof()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local last_line_idx = #lines  -- Total number of lines in the buffer

  -- Step 1: Clean whitespace from all lines
  for i = 1, last_line_idx do
    local line = lines[i]
    if line:match("%S") then
      -- For non-empty lines (contain visible characters):
      -- Remove only trailing whitespace (preserve leading whitespace)
      lines[i] = line:gsub("%s+$", "")
    else
      -- For empty lines (only spaces/tabs):
      -- Clean to a truly empty line (remove all whitespace)
      lines[i] = ""
    end
  end

  -- Step 2: Ensure exactly one trailing newline at the end of file (EOF)
  if last_line_idx == 0 then
    -- Handle completely empty files: add one empty line
    table.insert(lines, "")
  else
    -- Check content of the last line (after whitespace removal)
    local last_line_content = lines[last_line_idx]:gsub("%s+", "")

    if last_line_content ~= "" then
      -- Last line has content: append one empty line to satisfy EOF newline
      table.insert(lines, "")
    else
      -- Last line is already empty: remove excess empty lines (keep only one)
      -- Stop when there's only one line left to avoid deleting the final newline
      while #lines > 1 and lines[#lines - 1]:gsub("%s+", "") == "" do
        table.remove(lines, #lines - 1)  -- Remove penultimate empty line
      end
    end
  end

  -- Apply all modifications back to the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Trigger the function automatically before saving any file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",  -- Apply to all file types
  callback = trim_and_preserve_eof,
  desc = "Trim trailing whitespace, clean empty lines, and ensure single EOF newline on save"
})

