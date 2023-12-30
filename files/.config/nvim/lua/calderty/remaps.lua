local comment_toggle = require("comment_toggle")
local osc52 = require("calderty.osc52")
local api = vim.api


vim.keymap.set("i", "jk", "<Esc>", {})

vim.keymap.set("n", "<C-k>", "<Esc>:m .-2<CR>==")
vim.keymap.set("n", "<C-j>", "<Esc>:m .+1<CR>==")
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cprev<CR>")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "]q", ":cnext<cr>")
vim.keymap.set("n", "[q", ":cprev<cr>")

vim.keymap.set("n","Y", "y$")
vim.keymap.set("n","Y", "y$")

vim.keymap.set("n","gx", '<Cmd>call jobstart(["brave-browser", expand("<cfile>")])<CR>', {silent=true})

vim.keymap.set("n", "<leader>/", ":CommentToggle<CR>")
vim.keymap.set("v", "<leader>/", ":CommentToggle<CR>")

vim.keymap.set("x", "Y", osc52.copy_visual)


vim.keymap.set("n", "k", function()
	local count = api.nvim_get_vvar('count')
	local cmd
	if count == nil or count <= 10 then
		cmd = ""
	else
		 cmd = "m'" .. count
	end
	return cmd .. "k"
end, {expr=true})

vim.keymap.set("n", "j", function()
	local count = api.nvim_get_vvar('count')
	local cmd
	if count == nil or count <= 10 then
		cmd = ""
	else
		 cmd = "m'" .. count
	end
	return cmd .. "j"
end, {expr=true})

-- diff get left
vim.keymap.set("n", "<leader>ga", ":diffget //2<cr>", {})
-- diff get right
vim.keymap.set("n", "<leader>g;", ":diffget //3<cr>", {})
vim.keymap.set("v", "<leader>g;", ":diffget //3<cr>", {})
-- diff accept change
vim.keymap.set("v", "<leader>gg", ":diffget<cr>", {})
vim.keymap.set("n", "<leader>gg", ":diffget<cr>", {})
-- diff put change
vim.keymap.set("v", "<leader>gu", ":diffput<cr>", {})
vim.keymap.set("n", "<leader>gu", ":diffput<cr>", {})
