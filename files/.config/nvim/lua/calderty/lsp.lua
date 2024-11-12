vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)

		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		vim.keymap.set("n", "gd", vim.lsp.buf.definition , { buffer = ev.buf, remap = false, desc = "Go to definition"})
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, remap = false, desc = "Go to declaration"})
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = ev.buf, remap = false, desc = "Go to type definition" })
		vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { buffer = ev.buf, remap = false, desc = "Go to implementation"})
		vim.keymap.set("n", "K",  vim.lsp.buf.hover, { buffer = ev.buf, remap = false, desc = "Hover Help"})
		vim.keymap.set("n", "gr",  vim.lsp.buf.references, { buffer = ev.buf, remap = false, desc = "Find all references" })
		vim.keymap.set("n", "<leader>ws",  vim.lsp.buf.workspace_symbol, { buffer = ev.buf, remap = false,})
		vim.keymap.set("n", "<leader>wa",  vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, remap = false })
		vim.keymap.set("n", "<leader>wr",  vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, remap = false })
		vim.keymap.set("n", "<leader>wl",  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = ev.buf, remap = false })
		vim.keymap.set("n", "<leader>rn",  vim.lsp.buf.rename, { buffer = ev.buf, remap = false, desc = "Rename symbol"})
		vim.keymap.set("n", "<leader>ca",  vim.lsp.buf.code_action, { buffer = ev.buf, remap = false, desc = "Code Actions"})
		vim.keymap.set("n", "<leader>ge",  vim.diagnostic.open_float, { buffer = ev.buf, remap = false, desc= "View Diagnostic Message"})
		vim.keymap.set("n", "<leader>ff",  function() vim.lsp.buf.format({async=true}) end, { buffer = ev.buf, remap = false, desc = "Format File"})
		vim.keymap.set("n", "[d",  function () vim.diagnostic.jump({count=-1, float=true}) end, { buffer = ev.buf, remap = false, desc = "Go to previous diagnostic" })
		vim.keymap.set("n", "]d",  function () vim.diagnostic.jump({count=1, float=true}) end, { buffer = ev.buf, remap = false,  desc = "Go to next diagnostic"
})
	end
})

