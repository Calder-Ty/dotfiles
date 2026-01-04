vim.pack.add({{
	src= "https://github.com/lewis6991/gitsigns.nvim",
}})

local gitsigns = require("gitsigns")
gitsigns.setup({
	current_line_blame = true,
	current_line_blame_opts = {
		ignore_whitespace = true
	},
})

vim.keymap.set({'n', 'v'}, "<leader>ga", ":Gitsigns stage_hunk<CR>", {desc="Stage current hunk"})
vim.keymap.set({'n', 'v'}, "<leader>gq", ":Gitsigns reset_hunk<CR>", {desc="Reset current hunk"})
vim.keymap.set({'n'}, "<leader>gv", ":Gitsigns preview_hunk<CR>", {desc="View current hunk"})
vim.keymap.set({'n'}, "<leader>gs", ":Gitsigns setqflist all<CR>", {desc="Put all hunks into quickfix list"})
vim.keymap.set({'n'}, "<leader>gS", ":Gitsigns setqflist 0<CR>", {desc="Put current buffer hunks into quickfix list"})
vim.keymap.set({'n'}, "<leader>gc", ":!git commit<CR>", {desc="Commit"})
