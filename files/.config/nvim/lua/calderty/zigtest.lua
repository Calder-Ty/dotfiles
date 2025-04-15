-- Test Runner For Running Tests in Zig
tmux_pane = nil

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("CalderTyZigTest", {clear=true},
	callback = function()
		if tmux_pane == nil then
			vim.system({"", "test", "src/root.zig"},)
		end
	end
}

local get_pane_ids = function () {
		local panes = {}
		-- This Cryptic incantation will list all pane ID's
		-- see `man tmux` and `list-panes` command for more information
		cmd ={"tmux", "lsp", "-F", "#D"}

		vim.system(cmd, {
				stdout = function (_, data) {}
			}

		)

}
