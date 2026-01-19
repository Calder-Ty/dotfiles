vim.o.number = true
vim.o.rnu = true
vim.o.background = "dark"
vim.o.swapfile = false
vim.o.spell = true
vim.o.spelllang = 'en_us'
vim.o.spelloptions = 'camel'
vim.opt.termguicolors = true
vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.scrolloff=10
vim.opt.colorcolumn="100"
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.autoindent=true
vim.opt.swapfile=false
vim.opt.backup=true
vim.opt.backupdir= vim.env.HOME .. '/.local/share/nvim/backupdir'
vim.opt.undodir=vim.env.HOME .. '/.local/share/nvim/undodir'
vim.opt.undofile=true
vim.opt.completeopt="menu,menuone,fuzzy,noinsert"
vim.opt.lazyredraw = true
vim.opt.signcolumn='yes'
vim.opt.ruler=true
vim.g.netrw_liststyle=1
vim.g.netrw_sort_by='exten'
vim.g.netrw_sort_options='i'
vim.g.netrw_banner=0
vim.g.mapleader = ' '
vim.opt.listchars = { trail = '·', tab = '» ', leadmultispace = '│   '}
vim.opt.laststatus = 3
vim.opt.winborder = 'rounded'
vim.opt.pumborder = 'rounded'
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.complete = 'o,.,w,b'
vim.opt.efm = ""
vim.opt.efm:append({
	-- file/path.zig:18:36: error: use of undeclared identifier 'Allocator'
	"%f:%l:%c: %trror: %m",
	"%E%trror: %m: ====== expected this output: =========",
	"%Z%f:%l:%c: %m",
	-- error: 'elf.Header.decltest.parse' failed: file/path.zig:1:3
	"%trror: %m: %f:%l:%c:%.%#",
	"%f:%l:%c: %m",
	-- Ignore errors about commands failng
	"%-Eerror: the following command failed%.%#",
	"%-Z%f build-exe%.%#",
	-- error: /file/path.zig: non-conforming formatting
	"%trror: %f: %m",
	"%C%.%#",
})

