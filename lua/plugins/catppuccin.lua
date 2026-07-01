return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
  config = function()
    local kitty = require("config.kitty-palette").load()
    require("catppuccin").setup({
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },
        telescope = true,
      },
      color_overrides = {
        mocha = {
          base = kitty.background,
          mantle = kitty.background,
          crust = kitty.background,
          text = kitty.foreground,
          red = kitty.color1,
          green = kitty.color2,
          yellow = kitty.color3,
          blue = kitty.color4,
          mauve = kitty.color5,
          teal = kitty.color6,
          subtext1 = kitty.color7,
          overlay0 = kitty.color8,
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
