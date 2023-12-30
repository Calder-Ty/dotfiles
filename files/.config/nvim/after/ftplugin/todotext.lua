local api = vim.api

vim.keymap.set('n', '<C-j>', '/^[^x]<cr>', {buffer=true})
vim.keymap.set('n', '<C-k>', '?^[^x]<cr>', {buffer=true})
vim.keymap.set('n', '<leader>n', 'O<esc>:r ! date -I<cr>kkdj', {buffer=true})

-- Add the issue number based off of the inverse line number
local function get_issue_number()
	local cur_line = tonumber(vim.fn["line"]("."))
	local bottom_line = tonumber(vim.fn["line"]("$"))
	local issue_number = bottom_line - cur_line

	local col = tonumber(vim.fn["col"]("$")) - 1
	api.nvim_buf_set_text(0, tonumber(cur_line)-1, col, tonumber(cur_line)-1, col, {" issue:"..issue_number})
end

vim.keymap.set('n', '<leader>i', get_issue_number, {buffer=true})
