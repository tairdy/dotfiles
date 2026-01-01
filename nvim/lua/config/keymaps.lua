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
--keymap.set("n", "<tab>", "tabnext<Return>", opts)
--keymap.set("n", "<s-tab>", "tabprev<Return>", opts)
keymap.set("n", "<tab>", ":bnext<Return>")
keymap.set("n", "<s-tab>", ":bprev<Return>")

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
keymap.set("n", "C-w><down>", "<C-w>-")


--Markdown Preview
keymap.set("n", "<C-m>", ":MarkdownPreview<Return>")
keymap.set("n", "<C-t>", ":MarkdownPreviewToggle<Return>")
