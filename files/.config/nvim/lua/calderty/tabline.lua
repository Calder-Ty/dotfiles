if true
	then
	-- Turn off for now
	return
end
-- Load a Tabline to Give context information about where we are in the file
local api = vim.api
local o = vim.o
local cmd = vim.cmd

local M = {
	loc = ""
}

M.separators = {
  arrow = { '', '' },
  rounded = { '', '' },
  blank = { '', '' },
}

local act_sep = 'arrow'

local function highlight(group, fg, bg)
    cmd("highlight " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
end

function format_loc(plus, minus)
	return table.concat({
	"%#GitGutterAdd#",
	"+"..plus,
	"%#TabLine#",
	", ",
	"%#GitGutterDelete#",
	"-"..minus
	})
end


local function loc_changes()
	local line_counts = ""
	vim.fn.jobstart(
			'git log --numstat --pretty="%H" --since "2 weeks ago" --author "Tyler Calder"',
		{
			stdout_buffered=true,
			on_stdout = function(_, data)
				local out = parse_log_output(data)
				M.loc = format_loc(tostring(out.plus), tostring(out.minus))
				set_tabline()
			end,

			on_stderr = function(_, data)
				if not data
				then
					return
				end
				if data[1] == ""
				then
					return
				end
				-- We will just set it to be blank
				M.loc = ""
				set_tabline()
			end,
	})
end

function parse_log_output(lines)
	local res = {plus = 0, minus = 0}
	all_text = table.concat(lines, '\n')
	for plus, minus in string.gmatch(all_text, "(%d+)\t(%d+)\t")
	do
		res.plus = res.plus + tonumber(plus)
		res.minus = res.minus + tonumber(minus)
	end
	return res
end

function create_tabline()
	return table.concat({
		"",
		"%#FileType#",
		"%t ",
		"%#FileTypeAlt#",
		 M.separators[act_sep][1],
		"%#TabLine#",
		"%=",
		M.loc,
	})
end

function set_tabline()
	o.tabline = create_tabline()
end

function add_autocmd()
	api.nvim_create_augroup( "my_tabline", {clear=true})
	api.nvim_create_autocmd(
		{"BufEnter", "BufWinEnter"}, {
			group="my_tabline",
			callback=loc_changes,
		}
	)
end
add_autocmd()
set_tabline()
