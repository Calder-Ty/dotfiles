-- My Harpoon configuration
-- Maps are: fm: File-Mark
-- 			 fv: Flie-View
-- 			 fj: Go to file 1
-- 			 fk: Go to file 2
-- 			 fl: Go to file 3
-- 			 f;: Go to file 4
-- 			 fa: Go to Terminal 1
-- 			 fs: Go to Terminal 2
keymap = require("vim.keymap")
mark = require("harpoon.mark")
ui = require("harpoon.ui")
term = require("harpoon.term")

local function map(mode, lhs, rhs)
	local opts = { noremap = true }
	keymap.set(mode, lhs, rhs, opts)
end

local function go_to_harpoon_file(dest)
	return function() ui.nav_file(dest) end
end

local function go_to_harpoon_term(dest)
	return function() term.gotoTerminal(dest) end
end

map("n", "<leader>fm", mark.add_file)
map("n", "<leader>fv", ui.toggle_quick_menu)
map("n", "<leader>fj", go_to_harpoon_file(1))
map("n", "<leader>fk", go_to_harpoon_file(2))
map("n", "<leader>fl", go_to_harpoon_file(3))
map("n", "<leader>f;", go_to_harpoon_file(4))
-- Make sure i can jump back from terminal
map("t", "<leader>fm", mark.add_file)
map("t", "<leader>fv", ui.toggle_quick_menu)
map("t", "<leader>fj", go_to_harpoon_file(1))
map("t", "<leader>fk", go_to_harpoon_file(2))
map("t", "<leader>fl", go_to_harpoon_file(3))
map("t", "<leader>f;", go_to_harpoon_file(4))

map("n", "<leader>fa", go_to_harpoon_term(1))
map("n", "<leader>fs", go_to_harpoon_term(2))
-- Can jump between terminals
map("t", "<leader>fa", go_to_harpoon_term(1))
map("t", "<leader>fs", go_to_harpoon_term(2))

