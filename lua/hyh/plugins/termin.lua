return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-j>]],
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = 140,
        height = 35,
      },
    }
  end,
}

