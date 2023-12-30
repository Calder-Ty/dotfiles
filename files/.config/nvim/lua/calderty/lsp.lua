vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)

		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition , opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gr",  vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ws",  vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>wa",  vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr",  vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl",  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
		vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca",  vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>ge",  vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>ff",  function() vim.lsp.buf.format({async=true}) end, opts)
		vim.keymap.set("n", "[d",  vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d",  vim.diagnostic.goto_next, opts)
	end
})

