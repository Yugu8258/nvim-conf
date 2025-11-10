return {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
        "NvChad/nvim-colorizer.lua",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            local colorizer = require("colorizer")
            local tailwind_colorizer = require("tailwindcss-colorizer-cmp")

            -- 1. Core configuration: Strictly restrict to target file types
            colorizer.setup({
                -- Disable globally by default
                user_default_options = {
                    enabled = false,        -- Turn off color rendering for all files by default
                    tailwind = true,        -- Keep Tailwind CSS color class support (only active in specified files)
                    mode = "background",    -- Render mode (background color filling)
                    RGB = true,             -- Support RGB format (e.g., rgb(255,0,0))
                    RRGGBB = true,          -- Support RRGGBB format (e.g., #ff0000)
                    RRGGBBAA = true,        -- Support alpha-channel format (e.g., #ff000080)
                    names = false,          -- Disable color name rendering (e.g., "red") to avoid global interference
                },
                -- Enable only for specific file types and override global settings
                filetypes = {
                    html = { enabled = true },
                    css = { enabled = true },
                    javascript = { enabled = true },
                    typescript = { enabled = true },
                    jsx = { enabled = true },
                    tsx = { enabled = true },
                    vue = { enabled = true },
                    svelte = { enabled = true },
                    -- Explicitly disable for all other file types
                    ["*"] = { enabled = false }
                }
            })

            -- 2. Tailwind color preview in completion menu
            tailwind_colorizer.setup({
                color_square_width = 2,  -- Width of color preview squares in completion items
            })

            -- 3. Fixed autocmd: Attach colorizer only to specified file types
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                -- Match only extensions of target files
                pattern = {
                    "*.html", "*.css", "*.js", "*.ts",
                    "*.jsx", "*.tsx", "*.vue", "*.svelte"
                },
                callback = function()
                    -- Double-check filetype before attaching
                    if vim.tbl_contains(
                        { "html", "css", "javascript", "typescript", "jsx", "tsx", "vue", "svelte" },
                        vim.bo.filetype
                    ) then
                        vim.cmd("ColorizerAttachToBuffer")
                    end
                end
            })
        end,
    },
}

