-- This file can be loaded by calling `lua require("plugins")` from your init.vim
-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)

	-- Packer can manage itself
	use "wbthomason/packer.nvim"
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.0",
		-- or                            , branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } }
	}
	use {'nvim-telescope/telescope-ui-select.nvim',
		requires = { { "nvim-telescope/telescope.nvim" } }
	}
	use("theprimeagen/harpoon")
	use {
		"nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" },
		tag = "v0.8.0",
	}
	use("mbbill/undotree")
	use("tpope/vim-fugitive")

	use {
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp", commit = "1cad30fcffa282c0a9199c524c821eadc24bf939"},
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "hrsh7th/vim-vsnip" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		}
	}
	use "onsails/lspkind.nvim"

	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
	use { "simrat39/rust-tools.nvim" }
	use "nvim-tree/nvim-tree.lua"
	use "lewis6991/gitsigns.nvim"
	use "Calder-Ty/telescope-doit.nvim"
	use "Calder-Ty/comment_toggle.nvim"
	use "Calder-Ty/Monocle.nvim"
	use "tpope/vim-surround"
	use { "vim-test/vim-test", requires = { "skywind3000/asyncrun.vim" } }

	-- database stuff
	use "tpope/vim-dadbod"
	use "kristijanhusak/vim-dadbod-ui"
end)
