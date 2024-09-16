return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function(_, opts)

			local builtin = require("telescope.builtin")

			local defaults = {
				file_ignore_patterns = { ".git/" },
				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
					-- ABOVE are REQUIRED BY TELESCOPE,
					'--hidden'
				}
			}


			vim.keymap.set("n", "<leader>pf", function() builtin.find_files({no_ignore=false, hidden=true}) end, {})
			vim.keymap.set("n", "<leader><C-r>", builtin.registers, {})
			vim.keymap.set("n", "<C-p>", function() builtin.git_files(
				{
					hidden=true
			}) end, {})
			vim.keymap.set("n", "<leader>a", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>A", function() builtin.live_grep(
				{
					additional_args={
					"--no-ignore"
				}}
			) end, {})
			vim.keymap.set("n", "<leader>ps", builtin.grep_string, {})
			vim.keymap.set("n", "<leader><leader>d", builtin.diagnostics, {})
			vim.keymap.set("n", "<F1>", builtin.help_tags, {})
			vim.keymap.set("n", "<F11>", builtin.keymaps, {})
			vim.keymap.set("n", "z=", builtin.spell_suggest, {})

			require('telescope').setup {
				pickers = {
					find_files = {
						hidden = true,
					}
				},
				defaults = defaults,
				extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown {},
					}
				}
			}
		end,
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		dependencies = { { "nvim-telescope/telescope.nvim" } },
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}

