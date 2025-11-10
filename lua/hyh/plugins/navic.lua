return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig",  -- Dependency: Required for LSP configuration integration
    "nvim-tree/nvim-web-devicons",  -- Dependency: Provides icon support for file types/symbols
  },
  config = function()
    local navic = require("nvim-navic")

    -- Initialize the nvim-navic plugin
    navic.setup({
      -- Icon configuration (requires Nerd Font to display correctly)
      icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
      -- Separator between nested symbols (e.g., "Class > Method > Variable")
      separator = ' > ',
      -- Maximum depth of nested symbols to display (0 = no limit)
      depth_limit = 0,
      -- Indicator shown when symbols exceed the depth limit (e.g., "Class > Method > ..")
      depth_limit_indicator = "..",
      -- Enable syntax highlighting for symbols and separators
      highlight = true,
    })

    -- Create an autocommand group for managing the navic top bar (winbar)
    local augroup = vim.api.nvim_create_augroup("NavicTopBar", { clear = true })

    -- Attach navic to LSP clients when they connect to a buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      callback = function(args)
        -- Get the LSP client associated with the current buffer attachment
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- Only attach navic if the LSP client supports document symbol provider (required for navic to work)
        if client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, args.buf)
        end
      end,
    })

    -- Set up the winbar (top bar) to display navic's symbol location
    -- Uses Vimscript expression to dynamically fetch navic's current location
    vim.opt.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"

    -- Configure transparency and custom highlighting for the winbar and navic symbols
    local function setup_navic_hl()
      -- Make the winbar background transparent and set default text color
      vim.api.nvim_set_hl(0, 'WinBar', { bg = 'NONE', fg = '#8be9fd' })
      -- Custom highlight colors for specific symbol types
      vim.api.nvim_set_hl(0, 'NavicIconsFile', { fg = '#8be9fd' })    -- Color for "File" symbols
      vim.api.nvim_set_hl(0, 'NavicIconsMethod', { fg = '#50fa7b' })  -- Color for "Method" symbols
      vim.api.nvim_set_hl(0, 'NavicIconsFunction', { fg = '#50fa7b' })-- Color for "Function" symbols
      vim.api.nvim_set_hl(0, 'NavicIconsClass', { fg = '#ffb86c' })   -- Color for "Class" symbols
      vim.api.nvim_set_hl(0, 'NavicIconsVariable', { fg = '#bd93f9' })-- Color for "Variable" symbols
      vim.api.nvim_set_hl(0, 'NavicSeparator', { fg = '#6272a4' })    -- Color for the symbol separator
    end

    -- Reapply custom highlights when the colorscheme changes (prevents color conflicts)
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',  -- Trigger for any colorscheme switch
      callback = setup_navic_hl
    })
    -- Apply highlights immediately on plugin initialization
    setup_navic_hl()
  end
}

