-- Set Tab to ident the spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Set Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Enable Python3
vim.g.python3_host_prog = os.getenv("HOME") .. "/.local/share/nvim/venv/bin/python"

-- Disable automatic newline comments
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})
vim.api.nvim_set_keymap(
	"i",
	"<C-CR>",
	"<C-o>:setlocal formatoptions+=o<CR><C-o>o<C-o>:setlocal formatoptions-=o<CR>",
	{ noremap = true, silent = true }
)

-- Global LSP diagnostic configuration
vim.diagnostic.config({
	virtual_text = {
		prefix = "", -- icon shown before the message
		spacing = 2, -- space between code and message
	},
	signs = true, -- show icons in the sign column
	underline = true, -- underline problematic code
	update_in_insert = false, -- don't update while typing
})

-- Editor Configurations
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.scrolloff = 6

-- Replace swap and backup with undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

