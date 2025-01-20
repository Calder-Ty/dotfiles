local osc52 = require("calderty.osc52")
local api = vim.api
local touch = require("calderty.touch")


vim.keymap.set("i", "jk", "<Esc>", {desc="Escape insert Mode"})

vim.keymap.set("n", "<C-k>", "<Esc>:m .-2<CR>==", {desc="Shift line up"})
vim.keymap.set("n", "<C-j>", "<Esc>:m .+1<CR>==", {desc="Shift lines down"})
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", {desc="Shift selected lines down"})
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", {desc="Shift selected lines up"})
vim.keymap.set("n", "]q", ":cnext<CR>", {desc="Next Quick Fix Item"})
vim.keymap.set("n", "[q", ":cprev<CR>", {desc="Previous Quick Fix Item"})

vim.keymap.set("n","Y", "y$", {desc="Yank to end of line"})

vim.keymap.set("n","gx", '<Cmd>call jobstart(["brave-browser", expand("<cfile>")])<CR>', {silent=true, desc="Open Url in Browser"})

vim.keymap.set("x", "Y", osc52.copy_visual, {desc="Yank selection to clipboard"})

vim.keymap.set("n", "<leader>n", touch.directories, {desc="Create new file"})

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
vim.keymap.set("n", "<leader>ga", ":diffget //2<cr>", {desc="Merge Conflict: diff get left"})
vim.keymap.set("v", "<leader>g;", ":diffget //2<cr>", {desc="Merge Conflict: diff get selection left"})
-- diff get right
vim.keymap.set("n", "<leader>g;", ":diffget //3<cr>", {desc="Merge Conflict: diff get right"})
vim.keymap.set("v", "<leader>g;", ":diffget //3<cr>", {desc="Merge Conflict: diff get selection right"})
-- diff accept change
vim.keymap.set("v", "<leader>gg", ":diffget<cr>", {desc="Diff accept selected change"})
vim.keymap.set("n", "<leader>gg", ":diffget<cr>", {desc="Diff accept change"})
-- diff put change
vim.keymap.set("v", "<leader>gu", ":diffput<cr>", {desc="Diff put selected changes"})
vim.keymap.set("n", "<leader>gu", ":diffput<cr>", {desc="Diff put selected changes"})

vim.keymap.set("n", "<leader><leader>l", ":10sp .todo.tdt<CR>", {desc="Diff put selected changes"})
-- Snippets
vim.keymap.set({"i", "s"}, "<C-l>", function ()
	if vim.snippet.active({direction=1}) then
		vim.snippet.jump(1)
	end
end, {desc="Jump forward in the snippet"})
vim.keymap.set({"i", "s"}, "<C-h>", function ()
	if vim.snippet.active({direction=-1}) then
		vim.snippet.jump(-1)
	else
		return "<C-h>"
	end
end, {desc="Jump forward in the snippet"})

