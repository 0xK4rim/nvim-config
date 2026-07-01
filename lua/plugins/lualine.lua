return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- require('lualine').setup({
		--     options = {
		--         theme = 'dracula'
		--     }
		-- })
		local c = require("config.kitty-palette").load()
		require("lualine").setup({
			options = {
				theme = {
					normal = {
						a = { fg = c.background, bg = c.color4, gui = "bold" },
						b = { fg = c.foreground, bg = c.color0 },
						c = { fg = c.foreground, bg = c.background },
					},
					insert = {
						a = { fg = c.background, bg = c.color2, gui = "bold" },
					},
					visual = {
						a = { fg = c.background, bg = c.color5, gui = "bold" },
					},
					replace = {
						a = { fg = c.background, bg = c.color1, gui = "bold" },
					},
					command = {
						a = { fg = c.background, bg = c.color3, gui = "bold" },
					},
					inactive = {
						a = { fg = c.color8, bg = c.background },
						b = { fg = c.color8, bg = c.background },
						c = { fg = c.color8, bg = c.background },
					},
				},
			},
		})
	end,
}
