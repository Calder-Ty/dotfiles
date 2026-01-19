local api = vim.api
local touch = require("calderty.touch")
local osc52 = require("calderty.osc52")
local dis = require("calderty.dis")
local buffers = require("calderty.buffers")
-- General keymaps
vim.keymap.set("n", "<C-s>", ":w<CR>", {desc="Save file"})
vim.keymap.set("n", "<C-k>", "<Esc>:m .-2<CR>==", {desc="Shift line up"})
vim.keymap.set("n", "<C-j>", "<Esc>:m .+1<CR>==", {desc="Shift lines down"})
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", {desc="Shift selected lines down"})
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", {desc="Shift selected lines up"})
vim.keymap.set("n", "]q", ":cnext<CR>", {desc="Next Quick Fix Item"})
vim.keymap.set("n", "[q", ":cprev<CR>", {desc="Previous Quick Fix Item"})
vim.keymap.set("n", "<leader>/", "gcc", {desc="Comment out current line", remap=true})
vim.keymap.set("v", "<leader>/", "gc", {desc="Comment out selected lines", remap=true})

-- file navigation
vim.keymap.set("n", "<leader>fj", function() buffers.gotoPinnedFile(0) end, {})
vim.keymap.set("n", "<leader>fk", function() buffers.gotoPinnedFile(1) end, {})
vim.keymap.set("n", "<leader>fl", function() buffers.gotoPinnedFile(2) end, {})
vim.keymap.set("n", "<leader>f;", function() buffers.gotoPinnedFile(3) end, {})
vim.keymap.set("n", "<leader>fm", function() buffers.pinFile("%") end, {})
vim.keymap.set("n", "<leader>fM", function() buffers.unpinFile("%") end, {})

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

-- Compile Keymaps
vim.keymap.set("n", "<leader>e", ":cf<CR>:copen<CR>", {desc="Open quick fix list of compiler errors"})
vim.keymap.set("n", "<leader>E", ":e .errfile<CR>", {desc="Open errfile"})

-- Disassembly Module
-- od -> ObjectDump
vim.keymap.set("n", "<leader>od", dis.showDisassembly, {desc="Show this line's disassembly"})
