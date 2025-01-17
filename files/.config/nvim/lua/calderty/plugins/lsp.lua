RUST_OPTS = {
	capabilities = require('blink.cmp').get_lsp_capabilities(),
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
		dependencies = { "saghen/blink.cmp" },
		config = function(plugin, opts)
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local nvim_lsp = require('lspconfig')

			local default_opts = {
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				}
			}

			local py_opts = {
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
				pylsp = {
					cmd = { "pylsp" }
				}
			}


			local rust_opts = RUST_OPTS

			local zig_opts = {
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
				settings = {
					zls = {
						zls = {
							warn_style = true,
							inlay_hints_show_variable_type_hints = true,
							operator_completions = true,
							enable_autofix = true,
							enable_semantic_tokens = true,
							enable_build_on_save = true,
							build_on_save_step = "check",
							enable_inlay_hints = true,
						}
					}
				},
			}

			nvim_lsp.rust_analyzer.setup(rust_opts)
			nvim_lsp.pylsp.setup(py_opts)
			nvim_lsp.zls.setup(zig_opts)
			nvim_lsp.gopls.setup(default_opts)
			nvim_lsp.lua_ls.setup { default_opts }

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "󰌵",
						[vim.diagnostic.severity.INFO] = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					}

				}
			})
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
