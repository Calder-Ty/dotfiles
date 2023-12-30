local nvim_lsp = require('lspconfig')

local default_opts = {
	flags = {
		debounce_text_changes = 150,
	}
}

local py_opts = {
	flags = {
		debounce_text_changes = 150,
	},
	pylsp = {
		cmd = {"pylsp"}
	}
}


local rust_opts = {
	flags = {
		debounce_text_changes = 150,
	},
	tools = {
		autoSetHints = true,
-- 		hover_with_actions = true,
-- 		inlay_hints = {
-- 			show_parameter_hints = false,
-- 			parameter_hints_preifx = "",
-- 			other_hints_prefix = "",
-- 			highlight = "RustInlay",
-- 		},

	},
	server = {
		settings = {
			['rust-analyzer'] = {
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
				},
				completion = {
					autoimport = {
						enable = true
					},
				},
				procMacro = {
					enable = true
				},
				cargo = {
					loadOutDirsFromCheck = true
				},
				checkOnSave = {
					command = 'clippy'
				},
			}
		}
	},
}

local zig_opts = {
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		zls = {
			warn_style=true,
			inlay_hints_show_variable_type_hints=true,
	}
},
}
require('rust-tools').setup(rust_opts)
nvim_lsp.rust_analyzer.setup(rust_opts)
nvim_lsp.pylsp.setup(py_opts)
nvim_lsp.zls.setup(zig_opts)
nvim_lsp.gopls.setup(default_opts)

-- Setup Sign Column
local signs = { Error = "", Warn = "", Hint = "󰌵", Info = ""}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
