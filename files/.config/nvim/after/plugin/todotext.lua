
local function add_todo_text_filetype()
	group_name = "calderty_todotext"
	vim.api.nvim_create_augroup( group_name, {clear=true})
	vim.api.nvim_create_autocmd(
		{"BufRead", "BufNewFile"},
		{ group=group_name,
			pattern={"*.tdt", "*todo.txt"},
			command = "setfiletype todotext" }
	)
end

add_todo_text_filetype()
