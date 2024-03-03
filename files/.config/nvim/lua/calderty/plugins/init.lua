return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } }
	},
	{'nvim-telescope/telescope-ui-select.nvim',
		dependencies = { { "nvim-telescope/telescope.nvim" } }
	},
	{"theprimeagen/harpoon"},
	{
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate"
	},

	},
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/nvim-cmp", commit = "1cad30fcffa282c0a9199c524c821eadc24bf939"},
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/vim-vsnip" },

	{"onsails/lspkind.nvim"},

	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "simrat39/rust-tools.nvim" },
	{ "lewis6991/gitsigns.nvim" },
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
