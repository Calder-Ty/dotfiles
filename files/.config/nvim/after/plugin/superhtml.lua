local function create_superhtml_filetype()
	local group = vim.api.nvim_create_augroup('calderty_superhtml', { clear = true })
	vim.filetype.add({
		shtml='superhtml',
	})
	vim.api.nvim_create_autocmd('FileType', {
		group = group,
		pattern = 'superhtml',
		callback = function()
			vim.lsp.start {
				name = 'SuperHTML LSP',
				cmd = { 'superhtml', 'lsp' },
				root_dir = vim.loop.cwd(),
				flags = { exit_timeout = 1000, debounce_text_changes=150},
			}
		end,
	})
end

create_superhtml_filetype()
