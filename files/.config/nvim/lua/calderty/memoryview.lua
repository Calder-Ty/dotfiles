-- A Plugin to view in the debugger
local base64 = require("calderty.base64");
local ok, dap = pcall(require, "dap");
if not ok then
	-- Only load this plugin if dap is installed
	return
end

M = {}

---State for the plugin
---@class calderty.memoryview.state
---@field data string The raw bytes that back the view currently
---@field base_address string? the address that is the base for the view
local state = {
	data = "",
	base_address = nil,
	win = nil,
	buf = nil,
}
M.State = state


local augroup = vim.api.nvim_create_augroup("memoryview", {
	clear=true,
})


local isAscii = function(byte)
	return byte >= 32 and byte < 127
end

---Convert To Hex Bytes
---@param bytes string
---@return string[]
local toHexBytes = function (bytes)
	local result = {}
	local row = {}
	local r = 1
	local i = 1
	while i <= #bytes do
		local byte = bytes:byte(i)
		if (isAscii(byte)) then
			row[r] = string.format("%4s", string.char(byte))
		else
			row[r] = string.format("0x%02x", byte)
		end
		r = r + 1
		if r == 9 then
			result[i / 8] = table.concat(row, " ")
			r = 1
		end
		i = i + 1
	end
	return result
end

local makeBuf = function ()
	local bufno = vim.api.nvim_create_buf(false, true)
	if (bufno == 0) then
		error("Unable to create new buffer")
	end
	state.buf = bufno
	vim.bo[bufno].modeline = false
	vim.bo[bufno].bt = "nofile"
	vim.bo[bufno].ft = "memory"
end

local makeWindow = function ()
	state.win = vim.api.nvim_open_win(state.buf, true, {
		win = vim.api.nvim_get_current_win(),
		split= "right",
	})
	vim.wo[state.win].number = false;
	vim.wo[state.win].rnu = false;

	vim.api.nvim_create_autocmd({"WinClosed"}, {
		group=augroup,
		pattern=tostring(state.win),
		callback=function ()
			state.win = nil
			vim.api.nvim_buf_delete(state.buf, {
				force=true,
				unload=false,
			})
			state.buf = nil
		end
	})
end

---Displays the data we have from our request
local displayData = function ()
	if not state.base_address then
		print("No Location selected to read memory from yet.")
		return
	end
	if not state.buf then
		makeBuf()
	end
	if not state.win then
		makeWindow()
	end

	-- Get data and put it into hex strings
	local hex_bytes = toHexBytes(state.data)

	local addr = state.base_address
	local data = {}
	for i, row in ipairs(hex_bytes) do
		local a = string.format("0x%016x", ((i - 1) * 8) + tonumber(addr))
		data[i] = a .. ": " .. row
	end

	vim.api.nvim_buf_set_lines(state.buf, 0, #hex_bytes, false, data)
end


---Read the memory using the debug adapter
---@param session any: The active session object
---@param memoryReference string: The MemoryReference returned from debugging tool
local readMemory = function (session, memoryReference)
	local args = {
		memoryReference = tostring(memoryReference),
		offset = 0,  --TODO: go back and retrieve some data from prior to this point
		count = 2048,
	}
	coroutine.wrap(function()
		local err, result = session:request("readMemory", args)
		if err then
			print("Error fetching memory: "..vim.inspect(err))
			coroutine.yield(err)
		end
		state.data = base64.dec(result.data)
		state.base_address = result.address
		displayData()
	end)()
end


--TODO: I would like to be able to give an address to do this as well.
---Get a local memory reference to the named variable.
---@param session any
---@param name any
---@return nil
local getMemoryReference = function (session, name)
	for _, scope in ipairs(session.current_frame.scopes) do
		local var = nil
		for _, v in ipairs(scope.variables) do
			if v.name == name then
				var = v
				break
			end
		end
		if var and var.variablesReference then
			print("Memory Reference for " .. name .. ": " .. var.variablesReference)
			return var.variablesReference
		end
		print("Variable `"..name.."` not found or no memory reference available")
	end
end

local onStopped = function (sess, body)
	if not sess.capabilities.supportsReadMemoryRequest then
		return
	end
	if state.buf and state.base_address and state.win then
		readMemory(sess, state.base_address)
	end
end

---Creates a window and shows the memory in the window, Beginning
---at the location of a variable.
---@param name string: name of variable where to start showing memory
M.showInMemory = function (name)
	local sess = dap.session()
	if not state.sess then
		print("Unable to find active session to connect to")
		return
	end
	if not sess.capabilities.supportsReadMemoryRequest then
		-- TODO: Do fancy work to get name of the debug adapter
		print("Debug Adapter Does not support ReadMemory Requests")
		return
	end

	local memoryReference = getMemoryReference(sess, name)
	if memoryReference == nil then
		return
	end
	readMemory(sess, memoryReference)
end

M.showInMemoryAddr = function(address) 
	local sess = dap.session()
	if not sess then
		print("Unable to find active session to connect to")
		return
	end
	if not sess.capabilities.supportsReadMemoryRequest then
		-- TODO: Do fancy work to get name of the debug adapter
		print("Debug Adapter Does not support ReadMemory Requests")
		return
	end

	readMemory(sess, address)
end

---Setup memoryview system
---@param opts table A table of options. Currently there are none
M.setup = function (opts)
	_ = opts
	-- Register our handlers
	dap.listeners.after['event_stopped']['memoryview'] = onStopped
end


return M
