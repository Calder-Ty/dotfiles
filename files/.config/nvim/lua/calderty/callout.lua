-- A plugin for adding callouts to a file and displaying them in neovim, based
-- off a file or some such

local read_callout_file = function()
	local current_file = vim.api.nvim_buf_get_name(0)
	callout_file = current_file .. ".cout"
	local lines = {}
	status, line_gen = pcall(io.lines, callout_file)
	if not status then
		print("No callout file found for current buffer")
		return
	end
	for line in line_gen do
		lines[#lines+1] = line
	end
	return lines
end

--- Parse the contents of the Callout File, Create a structure of all ranges,
--- and content We want a range of lines, where we can then use to index the
--- callout to find
local parse_callout_file = function(lines)
	callout_table = {}
	section = {}
	key ='0,0'
	for i, line in pairs(lines) do
		if line == "====" then
			if #section ~= 0 then
				callout_table[key] = section
				section = {}
			end
			goto continue
		end

		local start, fin = string.find(line, "%%")
		if fin ~= nil and start == 1 then
			key=string.sub(line, fin+3, -1)
		else
			section[#section+1] = line
		end
		::continue::
	end
	if #section > 0 then
		callout_table[key] = section
	end
	return callout_table
end

local lookup_section = function(lineno, db)
	for key, value in pairs(db) do
		-- match the pattern %d,[%d]
		linenos = {}
		for sub in string.gmatch(key, '([^,]+)') do
			linenos[#linenos +1 ] = tonumber(sub)
		end
		if lineno >= linenos[1] and ( not linenos[2] or lineno <= linenos[2] ) then
			return value
		end
	end
end

local Window = function()
	w = {}
	w.height = vim.api.nvim_win_get_height(0)
	w.width = vim.api.nvim_win_get_width(0)

	return w
end


local make_callout = function()
	lines = read_callout_file()
	if lines == nil then
		return
	end
	data = parse_callout_file(lines)
	win = Window()

	local floater = vim.api.nvim_create_buf(false, true)
	if (floater == 0) then
		return
	end

	current_line = vim.api.nvim_win_get_cursor(0)[1]
	lines = lookup_section(current_line, data)
	if lines == nil then return end

	vim.api.nvim_buf_set_lines(floater, 0,-1, false, lines)

	vim.api.nvim_open_win(floater, false,
		{
			relative = "cursor",
			anchor = "NE",
			-- TODO: Make this dynamic
			width = 50,
			height = 20,

			row =  -10, -- Center it around the current line
			
			col = win.width - 1,
			border = "rounded",
			focusable = true,
		})
end

vim.api.nvim_create_user_command("CalloutTest", function(args)
	make_callout()
end, {})

vim.keymap.set("n", "<leader><leader>c", ":Callout<cr>", {silent=true})
