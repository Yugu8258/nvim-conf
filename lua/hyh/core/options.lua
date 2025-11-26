-- Disable netrw's top banner (file explorer header)
vim.cmd("let g:netrw_banner = 0")

-- Line numbers configuration
vim.opt.nu = true               -- Show absolute line numbers
vim.opt.relativenumber = true   -- Show relative line numbers (relative to cursor)

-- Indentation settings
vim.opt.tabstop = 4             -- Number of spaces a <Tab> counts for
vim.opt.softtabstop = 4         -- Number of spaces for <Tab> in insert mode
vim.opt.shiftwidth = 4          -- Number of spaces for auto-indentation
vim.opt.expandtab = true        -- Convert <Tab> to spaces
vim.opt.smartindent = true      -- Auto-indent new lines intelligently
vim.opt.wrap = false            -- Disable line wrapping

-- Backup and undo settings
vim.opt.swapfile = false        -- Disable swap files
vim.opt.backup = false          -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Directory for undo files
vim.opt.undofile = true         -- Enable persistent undo (retain undo history between sessions)

-- Search behavior
vim.opt.inccommand = "split"    -- Show live preview of substitutions in a split window

-- UI appearance
vim.opt.background = "dark"     -- Use dark background theme
vim.opt.scrolloff = 8           -- Keep 8 lines of context above/below cursor
vim.opt.signcolumn = "yes"      -- Always show the sign column (for git signs, diagnostics, etc.)

-- Window split behavior
vim.opt.splitright = true       -- Open vertical splits to the right of current window
vim.opt.splitbelow = true       -- Open horizontal splits below the current window

-- Miscellaneous settings
vim.opt.isfname:append("@-@")   -- Include "@-@" in valid filename characters
vim.opt.updatetime = 50         -- Faster update time for UI (affects diagnostics, git signs, etc.)
-- vim.opt.colorcolumn = "80"      -- Highlight column 80 (for code length guidelines)
vim.opt.clipboard:append("unnamedplus")  -- Sync clipboard with system clipboard
vim.opt.mouse = "a"             -- Enable mouse support in all modes

-- Case-insensitive search
vim.opt.ignorecase = true       -- Ignore case when searching
vim.opt.smartcase = true        -- Override ignorecase if search contains uppercase letters

-- Character set and encoding
vim.opt.fileencoding = "utf-8"  -- Encoding used when writing files
vim.opt.encoding = "utf-8"      -- Internal encoding for text processing
-- vim.opt.termencoding = "utf-8"   -- Encoding for terminal communication (commented out)

-- Wide character support (prevents alignment issues with multi-byte characters)
vim.opt.ambiwidth = "single"    -- Treat double-width characters (e.g., Chinese) as single-width (adjust based on terminal)

-- Encoding priorities for reading files
vim.opt.fileencodings = { "utf-8", "gbk", "gb2312", "cp936", "latin1" }  -- Try these encodings when opening files

-- Extend viminfo to save all marks (including local buffer marks)
vim.opt.viminfo:append("!")

