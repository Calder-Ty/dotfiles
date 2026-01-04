-- Themes: 
vim.pack.add({"https://github.com/rebelot/kanagawa.nvim"})

kanagawa =  require("kanagawa")
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
