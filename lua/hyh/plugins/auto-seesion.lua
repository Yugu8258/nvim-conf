return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            -- Disable automatic session restoration (manual trigger required)
            auto_restore_enabled = false,
            -- Directories where auto-session functionality is suppressed (no session save/restore)
            auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
            -- Optional: Session Lens configuration (enhanced session selection UI)
            session_lens = {
                -- Display shortened paths for sessions (avoids long path clutter)
                path_display = { "shorten" },
                -- Show border around the session selection interface for better visual separation
                theme_conf = { border = true },
            }
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
        keymap.set("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete current session" })
    end,
}

