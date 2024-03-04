return {
	{
		"folke/todo-comments.nvim",
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
				FIXME = {
					color = "error",
					alt = {"FIXIT", "FIX", "BUG", "ISSUE", "XXX"},
				},

				-- HACK: Watchout this is a hack
				HACK = {
					color = "warning",
				},

				-- WARN: This is the warning
				WARN = {
					color = "warning",
					alt = {"WARNING"},
				},

				-- PERF: noes on performance
				PERF = {
					color = "#243955",
					alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"},
				},

				-- NOTE: this is a note for you to look at
				NOTE = {
					color = "hint",
					alt = {"INFO"},
				},

				-- TODO: text that is highlighted as a todo note
				TODO = {
					color = "todo",
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
