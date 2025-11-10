local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "J", "mzJ'z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Clipboard things
-- Paste without replacing clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("v", "p", '"_dp', opts)

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
-- clears search highlights
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

vim.keymap.set("n", "<leader>w", vim.lsp.buf.format)
vim.keymap.set("n", "Q", "<nop>")
-- prevents deleted characters from copying to clipboard
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yan", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")    -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")  -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")      -- go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")      -- go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>")  -- open current tab in new tab

-- split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split widow
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
    vim.fn.setreg("+", filePath) -- Copy the path to the clipboard register
    print("File patah copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Disable arrow keys (applies to all modes)
local function disable_arrow_keys()
    -- Normal mode
    vim.keymap.set('n', '<up>', '<Nop>', { noremap = true, silent = true, desc = 'Disable up arrow key' })
    vim.keymap.set('n', '<down>', '<Nop>', { noremap = true, silent = true, desc = 'Disable down arrow key' })
    vim.keymap.set('n', '<left>', '<Nop>', { noremap = true, silent = true, desc = 'Disable left arrow key' })
    vim.keymap.set('n', '<right>', '<Nop>', { noremap = true, silent = true, desc = 'Disable right arrow key' })

    -- Insert mode
    vim.keymap.set('i', '<up>', '<Nop>', { noremap = true, silent = true, desc = 'Disable up arrow key in insert mode' })
    vim.keymap.set('i', '<down>', '<Nop>', { noremap = true, silent = true, desc = 'Disable down arrow key in insert mode' })
    vim.keymap.set('i', '<left>', '<Nop>', { noremap = true, silent = true, desc = 'Disable left arrow key in insert mode' })
    vim.keymap.set('i', '<right>', '<Nop>', { noremap = true, silent = true, desc = 'Disable right arrow key in insert mode' })

    -- Visual mode
    vim.keymap.set('v', '<up>', '<Nop>', { noremap = true, silent = true, desc = 'Disable up arrow key in visual mode' })
    vim.keymap.set('v', '<down>', '<Nop>', { noremap = true, silent = true, desc = 'Disable down arrow key in visual mode' })
    vim.keymap.set('v', '<left>', '<Nop>', { noremap = true, silent = true, desc = 'Disable left arrow key in visual mode' })
    vim.keymap.set('v', '<right>', '<Nop>', { noremap = true, silent = true, desc = 'Disable right arrow key in visual mode' })
end

-- Execute the function to disable arrow keys
disable_arrow_keys()

