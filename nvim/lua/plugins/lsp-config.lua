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

      -- 新方式: vim.lsp.config に登録して enable する
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim", "require" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.config("pyright", { capabilities = capabilities })
      vim.lsp.config("vimls", { capabilities = capabilities })

      -- 有効化
      vim.lsp.enable({ "lua_ls", "ts_ls", "jsonls", "pyright", "vimls" })

      -- keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },

}

