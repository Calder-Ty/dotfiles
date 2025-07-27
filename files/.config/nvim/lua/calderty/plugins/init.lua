return {
	{ "Calder-Ty/Monocle.nvim", },
	{ "Calder-Ty/ice-wyvern.nvim",
		init = function()
			require'icewyvern'.colorscheme()
		end
	},
	{ "tpope/vim-surround" },

	-- database stuff
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },

	-- Get Better
	-- {"m4xshen/hardtime.nvim"},
	-- {"nvim-treesitter/nvim-treesitter-context"},
}
