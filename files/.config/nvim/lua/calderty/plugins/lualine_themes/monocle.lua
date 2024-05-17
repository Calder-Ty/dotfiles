colors = require("monocle").colors

return {
	normal = {
		a = {bg = colors.shaddow, fg = colors.blue, gui = 'bold'},
		b = {bg = colors.black, fg = colors.darkblue},
		c = {bg = colors.none, fg = colors.green}
	},
	insert = {
		a = {bg = colors.shaddow, fg = colors.red, gui = 'bold'},
		b = {bg = colors.black, fg = colors.lightmagenta},
		c = {bg = colors.none, fg = colors.green}
	},
	visual = {
		a = {bg = colors.black, fg = colors.yellow, gui = 'bold'},
		b = {bg = colors.black, fg = colors.lightyellow},
		c = {bg = colors.none, fg = colors.green}
	},
	replace = {
		a = {bg = colors.shaddow, fg = colors.darkred, gui = 'bold'},
		b = {bg = colors.black, fg = colors.lightmagenta},
		c = {bg = colors.none, fg = colors.green}
	},
	command = {
		a = {bg = colors.black, fg = colors.darkgreen, gui = 'bold'},
		b = {bg = colors.black, fg = colors.seagreen},
		c = {bg = colors.none, fg = colors.green}
	},
	inactive = {
		a = {bg = colors.none, fg = colors.cobalt, gui = 'bold'},
		b = {bg = colors.none, fg = colors.cobalt},
		c = {bg = colors.none, fg = colors.cobalt}
	}
}
