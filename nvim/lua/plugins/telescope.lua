return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			--telescope keymaps
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", ";f", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", ";g", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", ";b", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", ";h", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
