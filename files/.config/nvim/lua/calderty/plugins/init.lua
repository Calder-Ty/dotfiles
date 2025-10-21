return {
	{ "Calder-Ty/Monocle.nvim", },
	{
		dir = "~/src/ice-wyvern.nvim",
	},
	{
		"rebelot/kanagawa.nvim",
		init = function()
			vim.cmd("colorscheme kanagawa")
		end,
		opts = {
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
		}
	},
	{ "tpope/vim-surround" },

	-- database stuff
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },

	-- Get Better
	-- {"m4xshen/hardtime.nvim"},
	-- {"nvim-treesitter/nvim-treesitter-context"},
}
