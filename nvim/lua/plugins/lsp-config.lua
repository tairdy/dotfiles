return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "jsonls", "pyright", "vimls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			  	settings = {
			  		Lua = {
			  			runtime = {
			  				-- Tell the language server which version of Lua you're using
			  				-- (most likely LuaJIT in the case of Neovim)
			  				version = "LuaJIT",
			  			},
			  			diagnostics = {
			  				-- Get the language server to recognize the `vim` global
			  				globals = {
			  					"vim",
			  					"require",
			  				},
			  			},
			  			workspace = {
			  				-- Make the server aware of Neovim runtime files
			  				library = vim.api.nvim_get_runtime_file("", true),
			  			},
			  			-- Do not send telemetry data containing a randomized but unique identifier
			  			telemetry = {
			  				enable = false,
			  			},
			  		},
			  	},
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
      })
			lspconfig.vimls.setup({
				capabilities = capabilities,
			})
			--	config = function()
			-- 			vim.lsp.config(
			-- 				'lua_ls',{
			-- 					settings = {
			-- 						['lua_ls'] = {},
			-- 					}
			-- 				},
			-- 				'ts_ls',{
			-- 					settings = {
			-- 						['ts_ls'] ={},
			-- 					},
			-- 				}
			--

			--keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
