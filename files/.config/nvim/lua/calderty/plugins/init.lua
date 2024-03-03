return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } }
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		dependencies = { { "nvim-telescope/telescope.nvim" } }
	},
	{"theprimeagen/harpoon"},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate"
	},
	{ "mbbill/undotree" },
	{ "hrsh7th/vim-vsnip" },

	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "Calder-Ty/telescope-doit.nvim" },
	{ "Calder-Ty/comment_toggle.nvim" },
	{ "Calder-Ty/Monocle.nvim" },
	{ "tpope/vim-surround" },
	{ "vim-test/vim-test", dependencies = { "skywind3000/asyncrun.vim" } },

	-- database stuff
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },

	-- Get Better
	-- {"m4xshen/hardtime.nvim"},
}
