colors = require("monocle").colors
local fn = vim.fn
local o = vim.o
local api = vim.api
local cmd = vim.cmd


local M = {}

M.separators = {
  arrow = { '', '' },
  rounded = { '◗', '◖' },
  blank = { '', '' },
}

local act_sep = 'arrow'


local function highlight(group, fg, bg)
    cmd("highlight " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
end

-- This is used to get the transition effect between groups
local function create_transition_group(left, right)
	group_name = "" .. left .. "alt" 
	l = M.groups[left]
	r = M.groups[right]
	highlight(group_name, l.bg, r.bg)
end

M.groups = {
	tabline			= { fg = colors.none,	bg = colors.none},
	statusline		= { fg = colors.none, bg = colors.none},
	statuslinenc	= { fg = colors.cobalt, bg = colors.none},
	statusmid		= { fg = colors.green,	bg = colors.none},
	statusright		= { fg = colors.red,		bg = colors.black},
	mode			= { fg = colors.black, bg = colors.blue},
	git				= { fg = colors.black, bg = colors.darkblue},
	statusleft		= { fg = colors.black, bg = colors.offblack},
	filetype		= { fg = colors.lightmagenta, bg = colors.offblack},
}

-- Setup Highlight Groups
for key, grp in pairs(M.groups) do 
	highlight(key, grp["fg"], grp["bg"])
end

if ( not( act_sep == "blank"))
	then
	create_transition_group("mode", "git")
	create_transition_group("git", "statusleft")
	create_transition_group("statusleft", "statusline")
	create_transition_group("filetype", "statusline")
end


local trunc_width = setmetatable({
  mode       = 80,
  git_status = 90,
  filename   = 140,
  line_col   = 60,
}, {
  __index = function()
      return 80
  end
})

local is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

local function GitStatus(git)
	if git then
		return string.format('  %s', git)
	else
		return ''
	end
end

local function FormatDiagnostics()
	local severity = vim.diagnostic.severity
	local summary = {
		errors= 0,
		warn = 0,
		info= 0,
		hint= 0,
	}
	for k, v in pairs(vim.diagnostic.get(0)) do
		if v['severity'] == severity.ERROR then
			summary['errors'] = summary['errors'] + 1
		elseif v['severity'] == severity.WARN then
			summary['warn'] = summary['warn'] + 1
		elseif v['severity'] == severity.INFO then
			summary['info'] = summary['info'] + 1
		else
			summary['hint'] = summary['hint'] + 1
		end
	end

	return summary
end


local mode_colors = {
	['i'] = { fg = colors.red, bg = colors.blue},
	['R'] = { fg = colors.red, bg = colors.blue},
	['ic'] = { fg = colors.red, bg = colors.blue},
	['v'] = { fg = colors.green, bg = colors.blue},
	['V'] = { fg = colors.green, bg = colors.blue},
	[''] = { fg = colors.green, bg = colors.blue},

}

local modes = setmetatable({
  ['n']  = {'Normal', 'N'};
  ['no'] = {'N·Pending', 'N·P'} ;
  ['v']  = {'Visual', 'V' };
  ['V']  = {'V·Line', 'V·L' };
  [''] = {'V·Block', 'V·B'};
  ['s']  = {'Select', 'S'};
  ['S']  = {'S·Line', 'S·L'};
  [''] = {'S·Block', 'S·B'};
  ['i']  = {'Insert', 'I'};
  ['ic'] = {'Insert', 'I'};
  ['R']  = {'Replace', 'R'};
  ['Rv'] = {'V·Replace', 'V·R'};
  ['c']  = {'Command', 'C'};
  ['cv'] = {'Vim·Ex ', 'V·E'};
  ['ce'] = {'Ex ', 'E'};
  ['r']  = {'Prompt ', 'P'};
  ['rm'] = {'More ', 'M'};
  ['r?'] = {'Confirm ', 'C'};
  ['!']  = {'Shell ', 'S'};
  ['t']  = {'Terminal ', 'T'};
}, {
  __index = function()
      return {'', ''} -- handle edge cases
  end
})

M.get_current_mode = function()
	 curr_mode = api.nvim_get_mode().mode
	 if mode_colors[curr_mode] ~= nil then
		 highlight("mode", mode_colors[curr_mode].fg, mode_colors[curr_mode].bg)
	 else
		 highlight("mode", M.groups["mode"].fg, M.groups["mode"].bg)
	 end
	 return string.format('[%s] ', modes[curr_mode][1]):upper()
end 



function status_line()
	local summary = FormatDiagnostics()
	--highlight("FileType", "green", "#442244")

    local statusline ={"",
     "%#StatusLine#",

	 "%#Mode#",
	 M.get_current_mode(),

	 "%#ModeAlt#",
	 M.separators[act_sep][1],

	 "%#Git#",
	 GitStatus(fn['fugitive#Head']()),

	 "%#GitAlt#",
	 M.separators[act_sep][1],

     "%#StatusLeft#",

     " %#DiagnosticError#",
     summary['errors'],
     " %#DiagnosticWarn#",
     summary['warn'],
     " %#DiagnosticHint#",
     summary['hint'],
     " %#DiagnosticInfo#",
     summary['info'],

	 " %#StatusLeftAlt#",
	 M.separators[act_sep][1],

     "%#StatusMid#",
     "%=",
     " %f ",
	 is_modified(),
     "%=",
     "%#FileTypeAlt#",
	 M.separators[act_sep][2],
	 "%#FileType# ",
	 "%Y ",
     "%l,%v",
 }
    return table.concat(statusline)

end

function is_modified ()
	if api.nvim_buf_get_option(0, "modified")
	then
		highlight("StatusMid", "#6a5acd", "#161616")
		return "●"
	end
	highlight("StatusMid", "green", "#161616")
	return ""
end


function status_line_nc()

    local statusline ={"",
     "%#StatusLineNC#",
     "%=%f%="
 }
    return table.concat(statusline)

end

function status_line_ex()
	return table.concat({"",
     "%#StatusLine#",
	 "%#Mode#",
	 " Ӂ ",
	 "%#ModeAlt#",
	 M.separators[act_sep][1]
 })
 end

Statusline = setmetatable({},{
	__call = function(sl, mode)
		if mode == "active" then return status_line() end
		if mode == "inactive" then return status_line_nc() end
		if mode == "explorer" then return status_line_ex() end
	end
})


api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType nvimtree setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]], false)

