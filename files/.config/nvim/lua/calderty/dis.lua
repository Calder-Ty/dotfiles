-- A lua Dissassembly viewer
local api = vim.api
if (vim.fn.executable('objdump') == 0) then
	return
end

----------------------------------------------------------------------------------------------------
------------------------------------------- Types --------------------------------------------------
----------------------------------------------------------------------------------------------------

---objdump Flags
---@class calderty.dis.Flags
---@field syntax "att" | "intel" What syntax to use 'att' or 'intel', default is 'att'
---@field dis_opts string[] List of target specific options to use, passed as the -M flag to objdump

---@class calderty.dis.Range
---@field first integer
---@field last integer

---@alias calderty.dis.LineInfo table<string, table<integer, calderty.dis.Range[]>>

---@class calderty.dis.State
---@field disassembly string[] The disassembly
---@field line_info calderty.dis.LineInfo?
---@field bin string?


----------------------------------------------------------------------------------------------------
------------------------------------------- Plugin -------------------------------------------------
----------------------------------------------------------------------------------------------------
M = {}

---@type calderty.dis.State
State = {disassembly={}}

---@type calderty.dis.Flags
local options = {
	syntax = 'att',
	dis_opts = {},
};

--- Set up the module
---@param opts calderty.dis.Flags Options to be used with the dissasembler
M.setup = function(opts)
	for k, v in pairs(opts) do
		options[k] = v
	end
	if (options.syntax == 'att' and #options.dis_opts == 0) then
		options[#options+1] = '-M'
		options[#options+1] = 'suffix'
	end
end

---@class calderty.dis.Parser
---@field state "search"|"scan"
---@field first integer
---@field currentfile string?
---@field lineno integer?

---@param state calderty.dis.Parser
---@param files calderty.dis.LineInfo
local record_range = function (state, files, i)
	local fr = files[state.currentfile] ~= nil and files[state.currentfile] or {}
	local lr = fr[state.lineno] ~= nil and fr[state.lineno] or {}
	lr[#lr+1] = {first=state.first, last=i-1}
	if (state.lineno == nil) then
		print(vim.inspect(state))
	end
	fr[state.lineno] = lr
	files[state.currentfile] = fr
end

---Processes the standard out of the file and returns
---a table of line data for every file in stdout
---@param disassembly string The result of an objdump
---@return calderty.dis.LineInfo
local process_stdout = function (disassembly)
	State.disassembly = vim.split(disassembly, "\n", {trimempty=true})
	---@type calderty.dis.LineInfo
	local files = {}
	-- Simple state machine for parsing disassembly
	-- We can be in the following states:
	-- Search: This is the first state. Here we search until
	--			We can find the first file name. Then we enter scan
	-- Scan: Where we are scanning the range of a block. We go until
	--		We find a blank line _or_ a new file name.
	---@type calderty.dis.Parser
	local parser = {
		state='search',
		first = 1,
		filename = nil,
		lineno = nil
	}
	for i, asm_line in ipairs(State.disassembly) do
		if parser.state == 'search' then
			if (asm_line:find("^/")) then
				parser.first = i
				local s = vim.split(asm_line, ':')
				parser.currentfile = s[1]
				parser.lineno = tonumber(vim.split(s[2], ' ', {trimempty=true})[1])
				parser.state = "scan"
				goto nextline
			end
		elseif parser.state == 'scan' then
			if (asm_line:find("^/")) then
				-- Record the range
				record_range(parser, files, i)
				-- Set state for next scan
				local s = vim.split(asm_line, ':')
				parser.currentfile = s[1]
				parser.lineno = tonumber(vim.split(s[2], ' ', {trimempty=true})[1])
				parser.first = i + 1
				parser.state = "scan"
				goto nextline
			elseif (asm_line == '') then
				-- Record the range
				record_range(parser, files, i)
				-- Go into search state
				parser.state = 'search'
				goto nextline
			end
		end
		::nextline::
	end
	return files
end

--- Dissassemble a binary and store its
---@param bin string The path to the binary that is to be dissassembled. Can be relatve to current working dirctory
---@return string
M.disassemble = function (bin)
	local co = coroutine.running()

	local cmd = {"objdump", "-dl", "-M", options.syntax }
	for _, value in ipairs(options) do
		cmd[# cmd+1] = value
	end
	cmd[#cmd+1] = bin

	local out = vim.system(cmd, {text=true}):wait()
	if (out.code ~= 0) then
		vim.notify("objdump failed with message:\n"..out.stderr,
		vim.log.levels.ERROR)
		error(out.stderr)
	end
	return out.stdout
end

---@param blocks calderty.dis.Range[]
local displayDisassembly = function (blocks, lineno)
	local asm_buf = api.nvim_create_buf(false, true)
	if asm_buf == 0 then error("Failed to create new buffer") end
	api.nvim_set_option_value('filetype', 'asm', {buf=asm_buf})
	local max_line_len = 0
	for i, range in ipairs(blocks) do
		local lines = {unpack(State.disassembly, range.first, range.last)}
		for _, line in ipairs(lines) do
			if line:len() > max_line_len then max_line_len = line:len() end
		end
		if i < #blocks then lines[#lines+1] = "//------//" end
		api.nvim_buf_set_lines(asm_buf, -1, -1, false, lines)
	end
	local current_line = api.nvim_get_current_line()
	local line_idx = string.find(current_line, "%S")

	-- NOTE: The output of objdump uses tabs between the Address and Opcodes
	-- we need to account for that in our max_line_len calculation as a tab
	-- counts for just 1 character, but takes up muliples spaces
	local tab_width = vim.lsp.util.get_effective_tabstop(asm_buf)
	api.nvim_open_win(asm_buf, false, {
		relative = 'win',
		-- NOTE: This lineno is 1 indexed, bufpos needs 0 indexed
		bufpos = {lineno-1, line_idx-1},
		width = vim.fn.min({api.nvim_win_get_width(0), max_line_len+line_idx + tab_width}),
		height = 10,
		style = "minimal",
		border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }
	})
end

---Shows the Dissassembly at the current line.
---TODO: Check if binary has been modified since last disassembly and re-run
M.showDisassembly = function()
	local thread = coroutine.create(function ()
		if State.line_info == nil then
			local co = coroutine.running()
			vim.ui.input({
				prompt = "Path> ",
				completion = "file",
			}, function (input)
					if input == nil then return end
					local ok, err = coroutine.resume(co, input)
					if ok ~= true then
						vim.notify(err, vim.log.levels.ERROR)
					end
			end)
			State.bin = coroutine.yield()
			local disassembly = M.disassemble(State.bin)
			State.line_info = process_stdout(disassembly)
		end
		local current_file = api.nvim_buf_get_name(0)
		local current_line = api.nvim_win_get_cursor(0)[1]
		local fi = State.line_info[current_file]
		if fi == nil then
			vim.notify("No assembly found for "..current_file,vim.log.levels.INFO)
			return
		end
		local li = fi[current_line]
		if li == nil then
			vim.notify("No assembly found for line #"..current_line ,vim.log.levels.INFO)
			return
		end
		displayDisassembly(li, current_line)
	end)
	local ok, err = coroutine.resume(thread)
	if ok ~= true then
		vim.notify(err, vim.log.levels.ERROR)
	end
end

return M
