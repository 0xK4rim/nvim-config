return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
    local cppcheck_tmp = vim.fn.stdpath("cache") .. "/none-ls-cppcheck"
    vim.fn.mkdir(cppcheck_tmp, "p")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.latexindent,
        null_ls.builtins.diagnostics.cppcheck.with({
          temp_dir = cppcheck_tmp,
        }),
				-- null_ls.builtins.diagnostics.cpplint,
				null_ls.builtins.diagnostics.pylint,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
