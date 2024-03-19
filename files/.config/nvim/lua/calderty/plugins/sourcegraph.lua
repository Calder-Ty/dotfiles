return {
	"sourcegraph/sg.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{"<leader>ss", "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>", desc="Search Sourcegraph"}
	}
}
