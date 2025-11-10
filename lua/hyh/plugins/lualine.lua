return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy', -- Load the plugin only when Neovim is fully initialized (reduces startup time)
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Dependency for rendering filetype icons in the statusline

  config = function()
    local lualine = require('lualine')

    -- Transparent theme configuration (Core: Set all 'bg' (background) values to 'NONE')
    local transparent_theme = {
      normal = { -- Style for Normal mode (default editing mode)
        a = { fg = '#8be9fd', bg = 'NONE', gui = 'bold' }, -- Section a (mode): Light blue text, bold, no background
        b = { fg = '#f8f8f2', bg = 'NONE' }, -- Section b (branch/diff): White text, no background
        c = { fg = '#6272a4', bg = 'NONE' }, -- Section c (filename): Purple-gray text, no background
        x = { fg = '#f8f8f2', bg = 'NONE' }, -- Section x (encoding/fileformat): White text, no background
        y = { fg = '#bd93f9', bg = 'NONE' }, -- Section y (progress): Purple text, no background
        z = { fg = '#8be9fd', bg = 'NONE', gui = 'bold' }, -- Section z (location): Light blue text, bold, no background
      },
      insert = { -- Style for Insert mode (text input mode)
        a = { fg = '#50fa7b', bg = 'NONE', gui = 'bold' }, -- Green text for Insert mode indicator
        b = { fg = '#f8f8f2', bg = 'NONE' },
      },
      visual = { -- Style for Visual mode (text selection mode)
        a = { fg = '#bd93f9', bg = 'NONE', gui = 'bold' }, -- Purple text for Visual mode indicator
      },
      replace = { -- Style for Replace mode (overwrite text mode)
        a = { fg = '#ff5555', bg = 'NONE', gui = 'bold' }, -- Red text for Replace mode indicator
      },
      command = { -- Style for Command mode (Vim command-line mode)
        a = { fg = '#ffb86c', bg = 'NONE', gui = 'bold' }, -- Orange text for Command mode indicator
      },
      inactive = { -- Style for inactive windows (e.g., unselected split panes)
        a = { fg = '#44475a', bg = 'NONE' }, -- Dark gray text (faded for inactivity)
        b = { fg = '#44475a', bg = 'NONE' },
        c = { fg = '#44475a', bg = 'NONE' },
      },
    }

    -- Override Lualine-related highlight groups (ensure transparency is applied consistently)
    local function setup_transparent_hl()
      vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' }) -- Set main statusline background to transparent
      vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' }) -- Set inactive window statusline background to transparent
      vim.api.nvim_set_hl(0, 'lualine_b_normal', { bg = 'NONE' }) -- Ensure section b in Normal mode has no background
      vim.api.nvim_set_hl(0, 'lualine_c_normal', { bg = 'NONE' }) -- Ensure section c in Normal mode has no background
    end

    -- Apply transparent highlight settings after a colorscheme is loaded (prevents theme conflicts)
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*', -- Trigger for any colorscheme change
      callback = setup_transparent_hl -- Run the transparency setup function
    })
    setup_transparent_hl() -- Apply transparency immediately on plugin load

    -- Initialize Lualine with transparent theme and custom settings
    lualine.setup({
      options = {
        theme = transparent_theme, -- Use the custom transparent theme defined above
        component_separators = { left = '', right = '' }, -- Small separators between individual components
        section_separators = { left = '', right = '' }, -- Larger separators between statusline sections
        globalstatus = true, -- Enable a single global statusline (instead of per-window statuslines) - Recommended for splits
      },
      sections = { -- Define what content appears in each statusline section (left to right)
        lualine_a = { 'mode' }, -- Section a: Current editing mode (e.g., NORMAL, INSERT)
        lualine_b = { 'branch', 'diff', 'diagnostics' }, -- Section b: Git branch, file diffs, LSP diagnostics
        lualine_c = { 'filename' }, -- Section c: Current file name
        lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- Section x: File encoding, line endings, filetype
        lualine_y = { 'progress' }, -- Section y: Progress (e.g., 50% through the file)
        lualine_z = { 'location' }, -- Section z: Cursor location (line:column)
      },
      extensions = { 'nvim-tree', 'toggleterm' }, -- Add Lualine support for Nvim-Tree (file explorer) and ToggleTerm (terminal)
    })
  end
}

