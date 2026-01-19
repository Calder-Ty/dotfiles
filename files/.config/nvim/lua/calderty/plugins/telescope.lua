vim.pack.add({
	{src = "https://github.com/nvim-telescope/telescope.nvim"},
	{src = "https://github.com/nvim-telescope/telescope-ui-select.nvim"},
})

require("telescope").setup({
	extension = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
}}})
require("telescope").load_extension('ui-select')
local builtin = require("telescope.builtin")
-- set keymaps
vim.keymap.set("n", "<leader>pf", function() builtin.find_files({no_ignore=false, hidden=true}) end, {})
vim.keymap.set("n", "<leader><C-r>", builtin.registers, {})
vim.keymap.set("n", "<C-p>", function() builtin.git_files(
	{
		hidden=true
}) end, {})
vim.keymap.set("n", "<leader>a", builtin.live_grep, {})
vim.keymap.set("n", "<A-f>", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>ps", builtin.grep_string, {})
vim.keymap.set("n", "<leader><leader>d", builtin.diagnostics, {})
vim.keymap.set("n", "<F1>", builtin.help_tags, {})
vim.keymap.set("n", "<F11>", builtin.keymaps, {})
vim.keymap.set("n", "z=", builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>vq", builtin.quickfix, {desc="View Quickfixlist"})
