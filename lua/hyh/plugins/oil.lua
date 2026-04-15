return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
        },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-c>"] = false,
          ["<M-h>"] = "actions.select_split",
          ["q"] = "actions.close",
        },
        delete_to_trash = true,
        view_options = {
          show_hidden = true,
        },
        skip_confirm_for_simple_edits = true,

        float = {
          -- 边框样式
          border = "rounded", -- 可选: 'single' | 'double' | 'rounded' | 'solid' | 'shadow' | 自定义数组

          max_width = 0.8,    -- 80% 屏幕宽
          max_height = 0.8,   -- 80% 屏幕高

          padding = 2,        -- 内边距
          win_options = {
            winblend = 0,     -- 透明度（0-100）
          },
        },
      })

      -- 快捷键
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open directory" })
      vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Float oil" })

      -- 光标线
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.cursorline = true
        end,
      })
    end,
  },
}

