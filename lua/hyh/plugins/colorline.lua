return {
  'yamatsum/nvim-cursorline',
  opts = {
    cursorline = {
      enable = true,
      timeout = 1000,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = {
        underline = true,
        -- 可以通过 highlight 命令自定义下划线厚度
        -- 这里只是配置插件使用的高亮组，实际样式需要另外设置
      },
    },
  },
  config = function(_, opts)
    require('nvim-cursorline').setup(opts)

    -- 自定义光标单词高亮样式，调整下划线厚度
    vim.api.nvim_set_hl(0, 'CursorWord', {
      underline = true,
      sp = '#5e81ac', -- 下划线颜色
      -- 下划线厚度通过 cterm 或 gui 选项间接控制
      -- 注意：实际效果可能因终端或 GUI 客户端而异
    })
  end,
}

