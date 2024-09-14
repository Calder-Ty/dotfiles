-- UI Functions for lua

-- Overrride vim.ui.input to be a nice window
-- Alot of this function was copied from https://www.reddit.com/r/neovim/comments/ua6826/3_lua_override_vimuiinput_in_40_lines/
local function ui_input(opts, on_confirm, win_opts)
	opts = opts or {}

	local buf = vim.api.nvim_create_buf(false, false)
	if buf == 0 then
		error("Buffer was not able to be created")
		return
	end
	vim.bo[buf].buftype = "prompt"
	vim.bo[buf].bufhidden = "wipe"

	local prompt = opts.prompt or ""
	local default_text = opts.default_text or ""

	local defered_callback = function (input)
		vim.defer_fn(function ()
			on_confirm(input)
		end, 10)
	end

	vim.fn.prompt_setprompt(buf, prompt)
	vim.fn.prompt_setcallback(buf, defered_callback)

	vim.keymap.set({ "i", "n" }, "<CR>", "<CR><Esc>:close!<CR>:stopinsert<CR>", {
        silent = true, buffer = buf })
    vim.keymap.set("n", "<esc>", "<cmd>close!<CR>", {
        silent = true, buffer = buf })


	local default_win_opts = {
		relative = "editor",
		row = vim.o.lines / 2 - 1,
		col = vim.o.columns / 2 - 25,
		width = 50,
		height = 1,
		style = 'minimal',
		border = 'rounded',
	}

	win_opts = vim.tbl_extend("force", default_win_opts, win_opts)
	win_opts.width = #default_text + #prompt + 5 < win_opts.width and win_opts.width or #default_text + #prompt + 5

	local win = vim.api.nvim_open_win(buf, true, win_opts)
	vim.api.nvim_set_option_value("winhighlight", "Search:None", {win=win})

	vim.cmd("startinsert")

	vim.defer_fn(function ()
		vim.api.nvim_buf_set_text(buf, 0, #prompt, 0, #prompt, {default_text})
		vim.cmd("startinsert!")
	end, 5)
end


vim.ui.input = function (opts, on_confirm)
	ui_input(opts, on_confirm, {})
end
