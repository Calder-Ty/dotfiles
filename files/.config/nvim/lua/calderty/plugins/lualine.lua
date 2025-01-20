local theme = require("calderty.plugins.lualine_themes.ice-wyvern")

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons'},
	opts = {
		options = {
			theme=theme,
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_x = {'encoding'},
			lualine_y = {'filetype'},
			lualine_z = {'location'},
		},
	},

	config = function (plugin, opts)

		local custom_fname = require('lualine.components.filename'):extend()
		local highlight = require'lualine.highlight'
		local default_status_colors = { saved = colors.green, modified = '#6a5acd' }


		function custom_fname:init(options)
		  custom_fname.super.init(self, options)
		  self.status_colors = {
			saved = highlight.create_component_highlight_group(
			  {fg = default_status_colors.saved}, 'filename_status_saved', self.options),
			modified = highlight.create_component_highlight_group(
			  {fg = default_status_colors.modified}, 'filename_status_modified', self.options),
		  }
		  if self.options.color == nil then self.options.color = '' end
		end

		function custom_fname:update_status()
		  local data = custom_fname.super.update_status(self)
		  data = highlight.component_format_highlight(vim.bo.modified
													  and self.status_colors.modified
													  or self.status_colors.saved) .. data
		  return data
		end

		local lualine_c = {"%=", {custom_fname, symbols = {
				modified = "●",
			},
			path=1,
		},}
		opts.sections.lualine_c = lualine_c
		require'lualine'.setup(opts)
	end
}
