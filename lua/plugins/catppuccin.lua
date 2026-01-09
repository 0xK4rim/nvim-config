return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
				},
				telescope = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
