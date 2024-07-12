return {
	{ "hrsh7th/vim-vsnip" },

	{
		"Calder-Ty/comment_toggle.nvim",
		lazy=false,
		keys = {
			{"<leader>/", ":CommentToggle<CR>", mode='n', desc="Toggle Comment"},
			{"<leader>/", ":CommentToggle<CR>", mode='v', desc="Toggle Comment"},
		},
	},
	{ "Calder-Ty/Monocle.nvim" },
	{ "tpope/vim-surround" },

	-- database stuff
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },

	-- Get Better
	-- {"m4xshen/hardtime.nvim"},
	-- {"nvim-treesitter/nvim-treesitter-context"},
}
