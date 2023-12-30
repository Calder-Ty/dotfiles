local ok, tree = pcall(require, "nvim-tree")
if not ok
then
	print("nvim-tree is not installed")
	return
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  disable_netrw=true,
  view = {
    adaptive_size = true,
 },
  renderer = {
    group_empty = true,
	icons = {
		show = {
			file = true,
			folder = true,
			folder_arrow = true,
			git = false,
		}
	}
  },
})

vim.keymap.set("n", "<A-a>", ":NvimTreeToggle<CR>")
