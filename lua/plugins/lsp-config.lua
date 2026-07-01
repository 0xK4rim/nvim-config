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
				ensure_installed = { "lua_ls", "clangd", "pyright", "texlab"},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				racket_langserver = {},
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("null_ls", { capabilities = capabilities })
			vim.lsp.enable("null_ls")
			vim.lsp.config("lua_ls", { capabilities = capabilities })
			vim.lsp.enable("lua_ls")
			vim.lsp.config("clangd", { capabilities = capabilities })
			vim.lsp.enable("clangd")
			vim.lsp.config("pyright", { capabilities = capabilities })
			vim.lsp.enable("pyright")
			vim.lsp.config("texlab", { capabilities = capabilities })
			vim.lsp.enable("texlab")
			vim.lsp.config("racket_langserver", {
				capabilities = capabilities,
				cmd = { "racket", "-l", "racket-langserver" },
				filetypes = { "racket", "scheme" },
			})
			vim.lsp.enable("racket_langserver")
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>act", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>suba", vim.lsp.buf.rename, {})
		end,
	},
}
