return {
	"0xK4rim/FCPT.nvim",
	config = function()
		require("FCPT").setup({
			test_file = "/home/Shinobid/Downloads/sample-cases.txt",
			sanitizer = false,
		})
	end,
}
