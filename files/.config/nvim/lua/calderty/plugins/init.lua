-- Themes: 
vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/tpope/vim-dadbod",
	"https://github.com/kristijanhusak/vim-dadbod-ui",
	"https://github.com/folke/todo-comments.nvim",
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

local kanagawa =  require("kanagawa")

kanagawa.setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none"
				}
			}
		},
	},
	background = {
		dark = "dragon"
	},
	overrides = function(colors)
	  local theme = colors.theme
	  local makeDiagnosticColor = function(color)
		local c = require("kanagawa.lib.color")
		return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
	  end

	  return {
		DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
		DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
		DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
		DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
	  }
	end
})
vim.cmd("colorscheme kanagawa")
-- Plenary: Required by Telescope
vim.pack.add({{src="https://github.com/nvim-lua/plenary.nvim"}})
-- Telescope
require("calderty.plugins.telescope")
-- Git
require("calderty.plugins.git")
-- Debugger
require("calderty.plugins.debugger")
