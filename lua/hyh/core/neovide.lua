-- Only load configuration in Neovide
if not vim.g.neovide then
	return
end

-- ======================== Appearance Settings ========================
-- 关键：窗口透明度必须调低，才能看到背景！
vim.g.neovide_opacity = 0.85  -- 必须 < 1.0，否则看不见背景
vim.g.neovide_window_blurred = true
vim.g.neovide_blur_amount_x = 8.0
vim.g.neovide_blur_amount_y = 8.0
vim.g.neovide_window_content_opacity = 1.0

-- ======================== 背景图片（100% 生效） ========================
vim.g.neovide_background_image = "/Users/hyh/Pictures/EditorWallpaper/neovide.jpg"
vim.g.neovide_background_opacity = 0.5  -- 背景强度调高
vim.g.neovide_background_mode = "cover"

-- Font
vim.opt.guifont = {
	"JetBrainsMono Nerd Font",
	"FiraCode Nerd Font",
	":h14",
}

vim.opt.termguicolors = true
vim.opt.background = "dark"

-- ======================== Animations & Interactions ========================
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_animate_window = true

-- ======================== Keybindings ========================
vim.g.neovide_input_use_logo = true
vim.keymap.set("v", "<D-c>", '"+y')
vim.keymap.set("n", "<D-v>", '"+P')
vim.keymap.set("i", "<D-v>", "<C-r>+")

vim.keymap.set("n", "<D-Enter>", "<cmd>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>")

vim.keymap.set("n", "<D-+>", function()
	local current = vim.opt.guifont:get()[2]
	vim.opt.guifont:set({ current:sub(2) + 1 })
end)
vim.keymap.set("n", "<D-->", function()
	local current = vim.opt.guifont:get()[2]
	vim.opt.guifont:set({ math.max(8, current:sub(2) - 1) })
end)

-- ======================== Other ========================
vim.g.neovide_menu_embed = false
vim.g.neovide_allow_touchpad_scrolling = true
vim.g.neovide_title = "Neovide"

