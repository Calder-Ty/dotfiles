RUST_OPTS = {
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

return { 
	{
		"neovim/nvim-lspconfig",
		config = function(plugin, opts)
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


			local rust_opts = RUST_OPTS

			local zig_opts = {
				flags = {
					debounce_text_changes = 150,
				},
				settings = {
					zls = {
						zls={
							warn_style=true,
							inlay_hints_show_variable_type_hints=true,
							operator_completions=true,
							enable_autofix=true,
							enable_semantic_tokens=true,
							enable_build_on_save=true,
							build_on_save_step="check",
						}
					}
				},
			}

			nvim_lsp.rust_analyzer.setup(rust_opts)
			nvim_lsp.pylsp.setup(py_opts)
			nvim_lsp.zls.setup(zig_opts)
			nvim_lsp.gopls.setup(default_opts)

			local signs = { Error = "", Warn = "", Hint = "󰌵", Info = ""}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end
	},
	{ 
		"simrat39/rust-tools.nvim",
		event = "BufEnter *.rs",
		config = function(plugin, opts)
			require('rust-tools').setup(RUST_OPTS)
		end
	},
}

