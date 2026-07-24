-- Manage my buffers and pin navigation
M = {}
local state_path = vim.fn.stdpath("state") .. "/buffers"

local id = vim.api.nvim_create_augroup('calderty.buffers', {
	clear = true,
})

-- Load and Store on Entry and Exit
vim.api.nvim_create_autocmd({"VimEnter"}, {
	group = id,
	pattern = "*",
	callback = function(ev)
		files = loadState()
		for i, value in ipairs(files) do
			vim.cmd("argadd ".. value)
		end
		vim.cmd.argdedupe()
	end,
})

vim.api.nvim_create_autocmd({"ExitPre"}, {
	group = id,
	callback = function(ev)
		storeState()
	end,
})

---Pin a file for quick Access. Works by adding file to the arglist
---@param filename string Name of file to be pinned
M.pinFile = function(filename)
	vim.cmd("argadd "..filename)
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

M.storeState = function()
	current_state = loadState()
	current_state[vim.fn.getcwd()] = vim.fn.argv()
	vim.print(current_state)
	mpack = vim.fn.msgpackdump({current_state}, 'B')
	fh, err = io.open(state_path, 'wb')
	if (fh == nil) then
		error(err)
	end
	fh:write(mpack)
	fh:close()
end

loadState = function()
	local blob = vim.fn.readblob(state_path, 0, -1)
	local data = vim.fn.msgpackparse(blob..'\0')
	--msgpackdump requires state to be sent in a list, so we have to get the first
	--item out of the list
	return data[1][vim.fn.getcwd()]
end

return M
