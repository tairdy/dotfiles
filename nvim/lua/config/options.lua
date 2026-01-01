vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.spell = false
	end,
})

--config options

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.number = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.shell = "fish"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.wrap = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- ESC時に英数入力に
if vim.fn.has('mac') == 1 then
  vim.api.nvim_create_autocmd({ 'FocusGained', 'InsertLeave', 'CmdlineLeave' }, {
    pattern = '*',
    callback = function()
      vim.fn.system([[osascript -l JavaScript -e 'Application("System Events").keyCode(102)']])
    end
  })
end

