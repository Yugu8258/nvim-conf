return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",

  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      open_mapping = [[<A-Enter>]], -- Alt+Enter 开关终端
      direction = "float",
      start_in_insert = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,

      -- 按屏幕占比设置宽高
      float_opts = {
        border = "curved",
        winblend = 0,
        title_pos = "center",
        -- 占比：0.85 = 85%，0.75 = 75%
        width  = math.floor(vim.o.columns * 0.85),
        height = math.floor(vim.o.lines   * 0.85),
      },
    })

    -- ESC 退出终端输入模式
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    end
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}

