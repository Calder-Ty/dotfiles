local config = vim.lsp.config

-- Lua
config['lua_ls'] = {
	-- Command and arguments to start the server.
	cmd = { 'lua-language-server' },
	-- Filetypes to automatically attach to.
	filetypes = { 'lua' },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
			}
		}
	}
}
vim.lsp.enable('lua_ls')

-- Zig
config['zls'] = {
	cmd = { 'zls' },
	filetypes = { 'zig', 'zir' },
	root_markers = { 'zls.json', 'build.zig', '.git' },
	workspace_required = false,
	setting = {
		warn_style = true,
		operator_completions = true,
		enable_autofix = true,
		enable_semantic_tokens = true,
		enable_build_on_save = true,
		build_on_save_step = "check",
	}
}

vim.lsp.enable('lua_ls')


-- Keymaps
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, remap = false, desc = "Go to definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, remap = false, desc = "Go to declaration" })
		vim.keymap.set("n", "grt", vim.lsp.buf.type_definition,
			{ buffer = ev.buf, remap = false, desc = "Go to type definition" })
		vim.keymap.set("n", "gri", vim.lsp.buf.implementation,
			{ buffer = ev.buf, remap = false, desc = "Go to implementation" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, remap = false, desc = "Hover Help" })
		vim.keymap.set("n", "gre", vim.diagnostic.open_float,
			{ buffer = ev.buf, remap = false, desc = "View Diagnostic Message" })
		vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format({ async = true }) end,
			{ buffer = ev.buf, remap = false, desc = "Format File" })
		vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
			{ buffer = ev.buf, remap = false, desc = "Go to previous diagnostic" })
		vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
			{ buffer = ev.buf, remap = false, desc = "Go to next diagnostic"
			})
	end
})
