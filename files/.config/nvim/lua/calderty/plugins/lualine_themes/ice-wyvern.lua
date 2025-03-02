colors = require("icewyvern").colors;

return {
	normal = {
		a = {bg = colors.black2, fg = colors.blue2, gui = 'bold'},
		b = {bg = colors.black3, fg = colors.blue3},
		c = {bg = colors.none, fg = colors.green1}
	},
	insert = {
		a = {bg = colors.black2, fg = colors.indigo1, gui = 'bold'},
		b = {bg = colors.black3, fg = colors.blue3},
		c = {bg = colors.none, fg = colors.green1}
	},
	visual = {
		a = {bg = colors.black2, fg = colors.yellow, gui = 'bold'},
		b = {bg = colors.black3, fg = colors.blue3},
		c = {bg = colors.none, fg = colors.green1}
	},
	replace = {
		a = {bg = colors.black2, fg = colors.white1, gui = 'bold'},
		b = {bg = colors.black3, fg = colors.blue3},
		c = {bg = colors.none, fg = colors.green1}
	},
	command = {
		a = {bg = colors.black2, fg = colors.green5, gui = 'bold'},
		b = {bg = colors.black3, fg = colors.blue3},
		c = {bg = colors.none, fg = colors.green1}
	},
	inactive = {
		a = {bg = colors.none, fg = colors.indigo1, gui = 'bold'},
		b = {bg = colors.none, fg = colors.blue3},
		c = {bg = colors.none, fg = colors.green1}
	}
}
