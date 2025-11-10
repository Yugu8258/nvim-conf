-- Only load configuration in Neovide
if not vim.g.neovide then
	return
end

-- ======================== Appearance Settings ========================
-- Window opacity (0.0-1.0)
vim.g.neovide_opacity = 0.7
-- Window background blur (0-10)
vim.g.neovide_window_blurred = true
vim.g.neovide_blur_amount_x = 8.0
vim.g.neovide_blur_amount_y = 8.0

-- Font configuration (Nerd Font recommended for icon support)
vim.opt.guifont = {
	"JetBrainsMono Nerd Font", -- Primary font
	"FiraCode Nerd Font", -- Fallback font
	":h18", -- Font size (adjust based on screen resolution)
}

-- Theme and colors (ensure termguicolors is enabled)
vim.opt.termguicolors = true
-- vim.cmd("colorscheme rose-pine-moon") -- Use your preferred theme

-- ======================== Animations & Interactions ========================
-- Cursor animation (railgun/pulse/beam/blink/off)
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_vfx_mode = "railgun" -- Cursor visual effect

-- Scroll animation (0 to disable, higher values = slower animation)
vim.g.neovide_scroll_animation_length = 0.2

-- Window resize animation
vim.g.neovide_animate_window = true

-- ======================== Keybindings & Behavior ========================
-- Use system clipboard for copy-paste
vim.g.neovide_input_use_logo = true -- Enable Cmd key (macOS)
vim.keymap.set("v", "<D-c>", '"+y') -- Cmd+C to copy
vim.keymap.set("n", "<D-v>", '"+P') -- Cmd+V to paste (normal mode)
vim.keymap.set("i", "<D-v>", "<C-r>+") -- Cmd+V to paste (insert mode)

-- Fullscreen toggle (Cmd+Enter)
vim.keymap.set("n", "<D-Enter>", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>")

-- Font size adjustment
vim.keymap.set("n", "<D-+>", function()
	local current = vim.opt.guifont:get()[2]
	vim.opt.guifont:set({ current:sub(2) + 1 }) -- Increase font size
end)
vim.keymap.set("n", "<D-->", function()
	local current = vim.opt.guifont:get()[2]
	vim.opt.guifont:set({ math.max(8, current:sub(2) - 1) }) -- Decrease font size (min 8)
end)

-- ======================== Other Optimizations ========================
-- Disable built-in menu (use Neovim's own menu system)
vim.g.neovide_menu_embed = false

-- Enable touchpad scrolling (if needed)
vim.g.neovide_allow_touchpad_scrolling = true

-- Window title
vim.g.neovide_title = "Neovide"

