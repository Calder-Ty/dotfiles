local colors = require("kanagawa.colors").setup({theme="dragon"});
local palette = colors.palette
local theme = colors.theme

Colors = {
	green = palette.autumnGreen,
	purple = palette.oniViolet,
}

return {
	normal = {
		a = {bg = theme.ui.bg, fg = palette.crystalBlue, gui = 'bold'},
		b = {bg = theme.ui.bg, fg = palette.dragonBlue},
		c = {bg = theme.ui.bg, fg = palette.autumnGreen}
	},
	insert = {
		a = {bg = theme.ui.bg, fg = palette.springBlue, gui = 'bold'},
		b = {bg = theme.ui.bg,  fg = palette.dragonblue},
		c = {bg = theme.ui.bg, fg = palette.autumnGreen}
	},
	visual = {
		a = {bg = theme.ui.bg, fg = palette.surimiOrange, gui = 'bold'},
		b = {bg = theme.ui.bg,   fg = palette.dragonblue},
		c = {bg = theme.ui.bg, fg = palette.autumnGreen}
	},
	replace = {
		a = {bg = theme.ui.bg, fg = palette.white1, gui = 'bold'},
		b = {bg = theme.ui.bg, fg = palette.dragonblue},
		c = {bg = theme.ui.bg, fg = palette.autumnGreen}
	},
	command = {
		a = {bg = theme.ui.bg, fg = palette.green5, gui = 'bold'},
		b = {bg = theme.ui.bg, fg = palette.dragonblue},
		c = {bg = theme.ui.bg, fg = palette.autumnGreen}
	},
	inactive = {
		a = {bg = theme.ui.bg, fg = palette.springBlue, gui = 'bold'},
		b = {bg = theme.ui.bg, fg = palette.dragonblue},
		c = {bg = theme.ui.bg, fg = palette.autumnGreen}
	}
}
