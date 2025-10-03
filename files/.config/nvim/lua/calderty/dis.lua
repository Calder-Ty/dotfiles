-- A lua Dissassembly viewer
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

---Call back for handling data from disassembler
---@param out vim.SystemCompleted
local objdump_cb = function (out)
	print("Running coroutine")
	if (out.code ~= 0) then
		error("objdump failed with message:\n"..out.stderr)
	end
	State.line_info = process_stdout(out.stdout)
	print("Completed  process_stdout")
	print(vim.inspect(State.line_info))
end

--- Dissassemble a binary and store its
---@param bin string The path to the binary that is to be dissassembled. Can be relatve to current working dirctory
M.disassemble = function (bin)
	local cmd = {"objdump", "-dl", "-M", options.syntax }
	for _, value in ipairs(options) do
		cmd[# cmd+1] = value
	end
	cmd[#cmd+1] = bin
	vim.system(cmd, {text=true}, objdump_cb)
end

return M
