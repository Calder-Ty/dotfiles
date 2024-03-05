return {
	{
		"folke/todo-comments.nvim",
		event="VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			signs = true,
			sign_priority = 8,
			highlight = {
				multiline = true,
				keyword = "bg",
				after = "fg",
			},
			keywords = {

				-- FIXME: Why is there no fixme symbol
					FIX = {
						color = "#FA5172",
					alt = {"FIXIT", "FIXME", "BUG", "ISSUE",},
				},

				-- HACK: Watchout this is a hack
				HACK = {
					color = "warning",
				},

				-- WARN: This is the warning
				WARN = {
					color = "warning",
					alt = {"WARNING", "XXX"},
				},

				-- SAFETY: This is a note about how we are safe
				SAFETY = {
					color = "#1db4d0",
					icon = "󰴰",
					alt = {"SAFTEY"}
				},

				-- PERF: noes on performance
				PERF = {
					color = "#77879c",
					alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"},
				},

				-- NOTE: this is a note for you to look at
				NOTE = {
					color = "hint",
					alt = {"INFO"},
				},

				-- TODO: text that is highlighted as a todo note
				TODO = {
					color = "#71f000",
					alt = {"TEST"},
				},


			},
			colors = {
				error = { "DiagnosticError" },
				warning = { "DiagnosticWarn" },
				todo = { "Comment" },
				hint = { "DiagnosticHint" },
				default = { "Identifier" },
			}
		},
		keys = {
			{"<leader><leader>t", ":TodoTelescope<cr>"}
		}
	},
}
