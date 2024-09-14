-- Create a new file using Telescope for fuzzy finding
local str = require("calderty.strings")
local ok, pickers = pcall(require, "telescope.pickers")
if not ok then
	error("Telescope not found")
	return
end

local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local make_entry = require("telescope.make_entry")

M = {}

M.directories = function (opts)
	opts = opts or {}
	local entry_maker = opts.entry_maker or make_entry.gen_from_string(opts)
	local results = vim.system({"fdfind", "--type", "d", "--hidden"}, {text=true},nil):wait()
	if results.code ~= 0 then
		error("Failed to conduct find")
	end

	local lines = str:split_lines(results.stdout or "")
	table.insert(lines, ".")
	for i = #lines, 1, -1 do
		if lines[i] == "" then
			table.remove(lines, i)
		end
	end

	pickers.new(opts, {
		prompt_title = "directory path",
		finder = finders.new_table(lines),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function (prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				print(vim.inspect(selection))
				vim.ui.input({default_text=selection[1].."/"}, function (input)
					if (string.sub(input, -1) ~= '/') then
						local pos, _ = string.match(input, "()([^/]+)$")
						vim.system({"mkdir", "-p", string.sub(input, 1, pos)}, {}):wait()
					else
						vim.system({"mkdir", "-p", input}, {}):wait()
					end
					vim.cmd(":e " .. input)
					end)
				end)
			return true
		end
	}):find()
end

return M
