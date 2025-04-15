return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "python", "rust", "lua", "bash", "json", "yaml", "markdown" },
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true, disable = { "yaml", "python", "zig" } },

				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = 'o',
						toggle_hl_groups = 'i',
						toggle_injected_languages = 't',
						toggle_anonymous_nodes = 'a',
						toggle_language_display = 'I',
						focus_language = 'f',
						unfocus_language = 'F',
						update = 'R',
						goto_node = '<cr>',
						show_help = '?',
					},
				},
			})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						}
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>sa"] = "@parameter.inner"
						},
						swap_previous = {
							["<leader>sA"] = "@parameter.inner"
						}
					},
					move = {
						enable = true,
						goto_next_start = {
							["]C"] = "@class.outer",
							["]m"] = "@function.outer",
						},
						goto_previous_start = {
							["[C"] = "@class.outer",
							["[m"] = "@function.outer",
						}
					}
				}
			});
		end
	}
}
