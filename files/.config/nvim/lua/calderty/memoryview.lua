-- A Plugin to view in the debugger
local base64 = require("calderty.base64");
local ok, dap = pcall(require, "dap");
if not ok then
	-- Only load this plugin if dap is installed
	return
end

---State for the plugin
local state = {
	data = "",
	base_address = nil,
}

M = {}

---Displays the data we have from our request
local displayData = function ()
	if !base_address then
		print("No Location selected to read memory from yet.")
	end
	buf = vim.api.nvim_create_buf(false, true)
	win = vim.api.nvim_open_win(buf, true, {
		win = vim.api.nvim_get_current_win()
		split= "right",
	})
	make_window()
end


---Read the memory using the debug adapter
---@param session any: The active session object
---@param address str: 
---@return integer[] : memory that was requested
local readMemory = function (session, memoryReference)
	local args = {
		memoryReference = memoryReference,
		offset = 0,  --TODO: go back and retrieve some data from prior to this point
		count = 2048,
	}
	local result = coroutine.wrap(function()
		local err, result = session:request("readMemory", args)
		if err then
			print("Error fetching memory: "..vim.inspect(err))
			coroutine.yield(err)
		end
		print("from coroutine: "..vim.inspect(result))
		return coroutine.yield(result)
	end)()
	state.data = base64.dec(result.data)
	state.base_address = result.address
end


--TODO: I would like to be able to give an address to do this as well.
---Get a local memory reference to the named variable.
---@param session any
---@param name any
---@return unknown
local getMemoryReference = function (session, name)
	for _, scope in ipairs(session.current_frame.scopes) do
		local var = scope.variables[name]
		if var and var.memoryReference then
			print("Memory Reference for " .. name .. ": " .. var.memoryReference)
			return var.memoryReference
		end
		print("Variable `"..name.."` not found or no memory reference available")
	end
end

---Creates a window and shows the memory in the window, Beginning
---at the location of a variable.
---@param name string: name of variable where to start showing memory
M.showInMemory = function (name)
	local sess = dap.session()
	if not sess then
		print("Unable to find active session to connect to")
		return
	end
	if not sess.capabilities.supportsReadMemoryRequest then
		-- TODO: Do fancy work to get name of the debug adapter
		print("Debug Adapter Does not support ReadMemory Requests")
	end

	local memoryReference = getMemoryReference(sess, name)
	if memoryReference == nil then
		return
	end
	readMemory(sess, memoryReference);
end




-- M.show_memory(0)
return M
