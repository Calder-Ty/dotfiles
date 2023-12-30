vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>")


-- Testing strategies
vim.cmd('let test#neovim#term_position = "bot 15"')
vim.cmd('let test#neovim#start_normal = 1')
vim.cmd('let test#strategy = "neovim"')

