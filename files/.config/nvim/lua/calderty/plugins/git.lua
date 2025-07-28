GitCompletionFunction = function(ArgLead, CmdLine, CursorPos)
	return {
		"bisect",
		"branch",
		"cherry pick",
		"commit",
		"diff",
		"fetch",
		"ignore",
		"log",
		"merge",
		"pull",
		"push",
		"rebase",
		"remote",
		"reset",
		"revert",
		"stash",
		"tag",
		"worktree",
	}
end

return {
	{
		"NeogitOrg/neogit",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			local neogit = require("neogit")

			vim.keymap.set("n", "<leader>gd", function() neogit.open({ "diff" }) end, { desc =
			"View diff of current file" })
			vim.keymap.set("n", "<leader>gs", function() neogit.open({ kind = "floating" }) end, { desc =
			"View git status" })
			vim.keymap.set("n", "<leader>gp", function() neogit.open({ "push" }) end, { desc = "Push commits to remote" })
			vim.keymap.set("n", "<leader>gl", function() neogit.open({ "log" }) end, { desc = "View git log" })

			-- Add A User Command that we can use to invoke any neogit thing:
			local git_func = function(args)
				local cmd = args["args"]
				neogit.open({ cmd })
			end

			vim.api.nvim_create_user_command("G", git_func, { nargs = 1, complete = GitCompletionFunction })
			neogit.setup({
				graph_style = "unicode",
				disable_context_highlighting = true,
				commit_editor = {
					show_staged_diff = false,
					kind = "tab"
				}
			})
		end,

		keys = {
			{ "<leader>gd", nil, desc = "View diff of current file" },
			{ "<leader>gs", nil, desc = "View git status" },
			{ "<leader>gp", nil, desc = "Push commits to remote" },
			{ "<leader>gl", nil, desc = "View git log" },
		}
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				ignore_whitespace = true
			},
		}
	},
}
