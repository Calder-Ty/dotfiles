opts = {
	tools = {
		inlay_hints = {
			auto = false,
		}
	},
	dap = {
		adapter = require('rust-tools.dap').get_codelldb_adapter(
			"/home/tyler/.local/share/nvim/mason/bin/codelldb",
			"/home/tyler/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
		)
	}
}
require('rust-tools').setup(opts)
