-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- For testing
vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })
vim.keymap.set("n", "<leader>lt", function()
	vim.cmd([[ PlenaryBustedFile % ]])
end)

-- Keep cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Remove F1 = help
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>")

-- Keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep cursor position while intending paragraphs
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Paste and delete without losing the paste buffer
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Copy to the clipboard buffer
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- <C-c> have the same behaviour as escape in insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Remove this obsolete mapping
vim.keymap.set("n", "Q", "<nop>")

-- Replace all the occurences in the whole file
vim.keymap.set("n", "<leader>subw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Copy the whole file to the clipboard
vim.keymap.set("n", "<leader>c", function()
	vim.cmd("%y+")
end)

-- Fetch Macros
vim.api.nvim_create_user_command("Macro", function()
	local source_file = vim.fn.expand("~/K/Study/CP/macros.txt")
	local lines = vim.fn.readfile(source_file)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	vim.api.nvim_buf_set_lines(0, row, row, false, lines)
	local target_row = nil
	local target_col = nil
	for i, line in ipairs(lines) do
		local start_col = string.find(line, "solve", 1, true)
		if start_col then
			target_row = row + i
			target_col = start_col + 3
			break
		end
	end
	if target_row and target_col then
		vim.api.nvim_win_set_cursor(0, { target_row + 1, target_col })
		vim.cmd("startinsert")
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
end, {})

-- C++ Fast run for CP
vim.g.cp_compile_flags = "-std=gnu++23 -O2 -pipe -march=native"
local function cp_run_kitty()
	vim.cmd("write")
	local src = vim.fn.expand("%:p")
	local bin = vim.fn.expand("%:p:r")
	local flags = vim.g.cp_compile_flags or ""
	local src_esc = vim.fn.shellescape(src)
	local bin_esc = vim.fn.shellescape(bin)
	local compile_cmd = string.format("g++ %s %s -o %s", flags, src_esc, bin_esc)
	local run_cmd = string.format("ulimit -s 262144 && %s", bin_esc)
	local full_cmd = compile_cmd .. " && " .. run_cmd .. ' ; echo ; read -n1 -s -r -p "Press any key to close..."'
	vim.fn.jobstart({ "kitty", "bash", "-ic", full_cmd }, { detach = true })
end

-- Python Fast run
local function python_run_venv()
	vim.cmd("write")
	local file = vim.fn.expand("%:p")
	local file_dir = vim.fn.fnamemodify(file, ":h")
	local venv = file_dir .. "/.venv/bin/python"
	local python = (vim.fn.executable(venv) == 1) and venv or "python3"
	local cd_esc = vim.fn.shellescape(file_dir)
	local python_esc = vim.fn.shellescape(python)
	local file_esc = vim.fn.shellescape(file)
	local run_and_hold = "cd "
		.. cd_esc
		.. " && "
		.. python_esc
		.. " "
		.. file_esc
		.. ' ; echo ; read -n1 -s -r -p "Press any key to close..."'
	if vim.fn.executable("kitty") == 1 then
		vim.fn.jobstart({ "kitty", "bash", "-ic", run_and_hold }, { detach = true })
		return
	end
	vim.notify("kitty not found — falling back to in-editor terminal split", vim.log.levels.WARN)
	vim.cmd("botright split")
	vim.cmd("resize 15")
	vim.fn.termopen({ "bash", "-ic", run_and_hold })
	vim.cmd("startinsert")
end

-- Dispatcher: pick runner by filetype or extension
local function run_current_file()
	local ft = vim.bo.filetype
	local ext = vim.fn.expand("%:e"):lower()
	if ft == "python" or ext == "py" then
		python_run_venv()
		return
	end
	if
		ft == "cpp"
		or ft == "c"
		or ft == "cxx"
		or ext == "cpp"
		or ext == "cc"
		or ext == "cxx"
		or ext == "c"
		or ext == "h"
		or ext == "hpp"
	then
		cp_run_kitty()
		return
	end
	vim.notify(
		"No runner configured for filetype: "
			.. (ft == "" and "<empty>" or ft)
			.. ". Try F5 again after opening a supported file.",
		vim.log.levels.INFO
	)
end
vim.keymap.set("n", "<leader>r", run_current_file, { noremap = true, silent = true })
