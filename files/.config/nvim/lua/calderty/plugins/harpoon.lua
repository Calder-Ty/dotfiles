return {
	{ 
		"theprimeagen/harpoon",
		branch='harpoon2',
		dependencies = {"nvim-lua/plenary.nvim"},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			-- My Harpoon configuration
			-- Maps are: fm: File-Mark
			-- 			 fv: Flie-View
			-- 			 fj: Go to file 1
			-- 			 fk: Go to file 2
			-- 			 fl: Go to file 3
			-- 			 f;: Go to file 4

			keymap = require("vim.keymap")

			local function go_to_harpoon_file(dest)
				return function() harpoon:list():select(dest) end
			end


			keymap.set("n", "<leader>fm", function() harpoon:list():add() end)
			keymap.set("n", "<leader>fv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
			keymap.set("n", "<leader>fj", go_to_harpoon_file(1))
			keymap.set("n", "<leader>fk", go_to_harpoon_file(2))
			keymap.set("n", "<leader>fl", go_to_harpoon_file(3))
			keymap.set("n", "<leader>f;", go_to_harpoon_file(4))
		end,
	},
}
