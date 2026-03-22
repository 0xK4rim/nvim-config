return {
	"lervag/vimtex",
	ft = { "tex", "plaintex" },
	config = function()
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			executable = "latexmk",
			options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
		}
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_view_general_viewer = "sioyek"
		vim.g.vimtex_view_general_options = "--synctex-forward @line:@col:@tex @pdf"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_fold_enabled = 1

		local map = vim.keymap.set
		map("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { desc = "LaTeX: Compile" })
		map("n", "<leader>lk", "<cmd>VimtexStop<CR>", { desc = "LaTeX: Stop compile" })
		map("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "LaTeX: Open viewer" })
		map("n", "<leader>li", "<cmd>VimtexInverseSearch<CR>", { desc = "LaTeX: Inverse search" })
		map("n", "<leader>ll", "<cmd>VimtexCompileSS<CR>", { desc = "LaTeX: start/stop (SS)" })
	end,
}
