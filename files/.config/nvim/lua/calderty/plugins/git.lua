local telescope = require("telescope.builtin")

vim.pack.add({
	{ src= "https://github.com/lewis6991/gitsigns.nvim", },
	{ src= "https://github.com/tpope/vim-fugitive"},
})

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
vim.keymap.set({'n'}, "<leader>gh", ":Gitsigns setqflist all<CR>", {desc="Put all hunks into quickfix list"})
vim.keymap.set({'n'}, "<leader>gH", ":Gitsigns setqflist 0<CR>", {desc="Put current buffer hunks into quickfix list"})
vim.keymap.set({'n'}, "<leader>gs", telescope.git_status, {desc="Git Status"})
vim.keymap.set({'n'}, "<leader>gc", ":G commit<CR>", {desc="Commit"})
