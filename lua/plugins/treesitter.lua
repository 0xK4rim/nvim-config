return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "all", "lua", "python", "c", "cpp", "latex" },
				callback = function()
					vim.treesitter.start()
				end,
			})
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	},
	{
		"mks-h/treesitter-autoinstall.nvim",
		config = function()
			require("treesitter-autoinstall").setup({
				ignore = {},
				highlight = true,
				regex = {},
			})
		end,
	},
}
