-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set("n", "dw", "vb-d")

--select all
keymap.set("n", "<C-a>", "gg<S-v>G")

--jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

keymap.set("n", "te", "tabedit")
keymap.set("n", "<tab", "tabnext<Return>", opts)
keymap.set("n", "<s-tab>", "tabprev<Return>", opts)

keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "sc", ":bd<Return>")

keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<C-b>", "<cmd>Telescope buffers<cr>")
