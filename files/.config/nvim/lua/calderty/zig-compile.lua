-- integrate zig build --watch into compiler
local errfile = vim.fn.getcwd() .. "/.errfile"
vim.opt.errorfile = errfile
M = {}
State = {
	cmd = {"zig", "build", "-fincremental"},
	status = -1
}

local status_codes = {
	ok = "[OK]",
	fail = "[FAIL]",
	err = "[ERR]",
	run = "[RUN]",
	unk = "[UNK]"
}

---@param out vim.SystemCompleted
local compileExitHandler = function(out)
	State.status = out.code

	-- write to state file
	local fh, err = io.open(errfile, 'w+')
	if (err) then error(err) end
	_, err = fh:write(out.stderr)
	if err then error(err) end
	fh:flush()
end

M.compile = function()
	vim.system(State.cmd, {text=true}, compileExitHandler)
end

M.status = function()
	local status = ""
	if State.status == 0 then
		status = "%#DiagnosticInfo#"..status_codes.ok .."%*"
	elseif State.status == -1 then
		status = "%#DiagnosticInfo#"..status_codes.unk .."%*"
	elseif State.status == 2 then
		status = "%#DiagnosticError#"..status_codes.err .."%*"
	else
		status = "%#DiagnosticWarn#"..status_codes.fail .."%*"
	end
	return status
end

local group = vim.api.nvim_create_augroup('calderty.zig-compile', {clear=true})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = {"*.zig"},
	desc = "Build on Save",
	callback = function(_) M.compile() end
})

return M
