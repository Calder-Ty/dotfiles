local group = vim.api.nvim_create_augroup("calderty.treesitter", {clear=true})
vim.api.nvim_create_autocmd(
	{'FileType'}, {
		group = group,
		callback = function(ev)
			pcall(vim.treesitter.start, ev.buf)
		end }
)
