return {
		"vim-test/vim-test",
		dependencies = { "skywind3000/asyncrun.vim" },
		keys = {
			{"<leader>tt", ":TestNearest<CR>", desc="Test the current test"},
			{"<leader>tf", ":TestFile<CR>", desc="Test Current file"},
			{"<leader>ta", ":TestSuite<CR>", desc="Test All files"},
		},
		config = function()
			-- Testing strategies
			vim.cmd('let test#neovim#term_position = "bot 15"')
			vim.cmd('let test#neovim#start_normal = 1')
			vim.cmd('let test#strategy = "neovim"')

		end,
}

