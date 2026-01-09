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
				ensure_installed = { "lua_ls", "clangd", "pyright", "texlab", "ts_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("null_ls", { capabilities = capabilities })
      vim.lsp.enable("null_ls")
			vim.lsp.config("lua_ls", { capabilities = capabilities, })
			vim.lsp.enable("lua_ls")
			vim.lsp.config("clangd", { capabilities = capabilities, })
			vim.lsp.enable("clangd")
			vim.lsp.config("pyright", { capabilities = capabilities, })
			vim.lsp.enable("pyright")
			vim.lsp.config("texlab", { capabilities = capabilities })
			vim.lsp.enable("texlab")
			vim.lsp.config("ts_ls", { capabilities = capabilities })
			vim.lsp.enable("ts_ls")
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ta", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>suba", vim.lsp.buf.rename, {})
		end,
	},
}
