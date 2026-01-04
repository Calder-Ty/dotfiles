-- Manage my buffers and pin navigation

M = {}

---Pin a file for quick Access. Works by adding file to the arglist
---@param filename string Name of file to be pinned
M.pinFile = function(filename)
	vim.cmd("$argadd "..filename)
	vim.cmd.argdedupe()
end

M.unpinFile = function(filename)
	vim.cmd.argd(filename)
end

M.gotoPinnedFile = function(idx)
	local filename = vim.fn.argv(idx)
	if (filename == '') then
		return
	end
	vim.cmd.edit(filename)
end


return M
