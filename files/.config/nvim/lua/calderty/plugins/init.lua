-- Themes: 
vim.pack.add({
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/folke/todo-comments.nvim",
    "https://github.com/stevearc/oil.nvim",
})

local todo = require("todo-comments")
todo.setup({
	signs=false,
	gui_style = {
		fg = "NONE",
		bg = "NONE",
	},
	highlight = {
		multiline = false,
		keyword = "fg",
		after = "",
	}
})

-- oil
require("oil").setup({
	columns = {
		"icon",
		"permission",
		"size",
		"mtime",
	},
	keymaps = {
		["<C-p>"] = false,
		["<C-s>"] = false,
	}
})

vim.cmd("colorscheme minima")
-- Plenary: Required by Telescope
vim.pack.add({{src="https://github.com/nvim-lua/plenary.nvim"}})
-- Telescope
require("calderty.plugins.telescope")
-- Git
require("calderty.plugins.git")
-- Debugger
require("calderty.plugins.debugger")
