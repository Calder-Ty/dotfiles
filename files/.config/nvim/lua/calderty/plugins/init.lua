return {
	{ "Calder-Ty/Monocle.nvim", },
	{ "Calder-Ty/ice-wyvern.nvim",
		init = function()
			require'icewyvern'.colorscheme()
		end
	},
	{
		"Calder-Ty/comment_toggle.nvim",
		lazy=false,
		keys = {
			{"<leader>/", ":CommentToggle<CR>", mode='n', desc="Toggle Comment"},
			{"<leader>/", ":CommentToggle<CR>", mode='v', desc="Toggle Comment"},
		},
	},
	{ "tpope/vim-surround" },

	-- database stuff
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },

	-- Get Better
	-- {"m4xshen/hardtime.nvim"},
	-- {"nvim-treesitter/nvim-treesitter-context"},
}
