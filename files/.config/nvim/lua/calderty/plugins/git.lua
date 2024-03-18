return {
	{
		"tpope/vim-fugitive",
		-- Not Lazy for now because my statusline uses it
		event = "VeryLazy",
		keys = {
			{"<leader>gd", ":vert Gdiffsplit<cr>", desc="View diff of current file"},
			{"<leader>gs", ":G<CR>", desc="View git status"},
			{"<leader>gp", ":Git push<CR>", desc="Push commits to remote"},
			{"<leader>gl", ":Git log<CR>", desc="View git log"},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame=true,
			current_line_blame_opts = {
				ignore_whitespace=true,
			},
		},
	},
}

