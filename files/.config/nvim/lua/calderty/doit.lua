-- A Plugin for working with a todo.tdt/todo.txt file in Neovim
--
-- Goals:
--   - View The todo.txt file
--		- Filter on tags
--   - Be able to add Tasks
--
-- Problem:
--	 - How do I allow for editing the file / adding new stuff, without
--	   Deleting or ruining old tasks.
--	 - How do I filter the tasks?
--
-- Solution:
--   - Add a prompt at the bottom of the display, that will be used to interact with todo list.
--   - Collect those items and write them to the file

local M = {}

---@class doit.TodoList
---@fields list string[]: the list of todo Items

--- Read in the todo list
---@param fi string: The todo file to be read in
---@return doit.TodoList
local function readTodoList(fi)
	local file = io.open(fi, "r")
	local lines = {}
	if file then
		for ln in file:lines() do
			lines[#lines + 1] = ln
		end
		return { list = lines }
	else
		error("Unable to locate file: " .. fi, 1)
		return { list = {} }
	end
end


--- Display a task list
--- @param tasks doit.TodoList: The list of tasks
--- @return integer: The Window ID of the displayList
local function displayList(tasks)

	local buffer = vim.api.nvim_create_buf(false, false)
	if (buffer == 0) then
		error("Failed to create new buffer", 1)
	end
	vim.api.nvim_set_option_value("filetype", "todotext", {buf=buffer})
	vim.api.nvim_buf_set_lines(buffer, 0, 0, true, tasks["list"])
	local win = vim.api.nvim_open_win(buffer, true,
		{
			relative = "win",
			row = 5,
			col = 10,
			width = vim.api.nvim_win_get_width(0) - 20,
			height = vim.api.nvim_win_get_height(0) - 15,
			style = "minimal",
			border = "rounded",
			title = "Just DO IT!",
			title_pos = "center",
		}
	)
	return win
end

--- Build out the prompt, used to filter and write new tasks
--- @param viewWin: The Window Id of the todolist viewer
local function prompt (viewWin)
	local buffer = vim.api.nvim_create_buf(false,false)
	if (buffer == 0) then
		error("Failed to create new buffer", 1)
	end
	vim.api.nvim_open_win(buffer, true, {
		relative= "win",
		win= viewWin,
		width = vim.api.nvim_win_get_width(viewWin),
		height = 1,
		row = vim.api.nvim_win_get_height(viewWin) + 1,
		col = -1,
		border = "rounded",
	})
end

-- ViewList of things todo items
local function DoIt()
	local tasks = readTodoList(".todo.tdt")
	local viewWin = displayList(tasks)
	prompt(viewWin)
end

DoIt()

return M
