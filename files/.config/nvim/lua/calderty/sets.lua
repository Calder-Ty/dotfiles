-- Setings
vim.opt.laststatus=3
vim.opt.termguicolors = true
vim.opt.showtabline=0
vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.scrolloff=15
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


vim.opt.signcolumn="yes"
vim.opt.ruler=true
vim.opt.nu = true
vim.opt.rnu = true
-- " Faster macros
vim.opt.lazyredraw = true
-- " show matching {[()]}
vim.opt.showmatch = true
-- " folding
vim.opt.foldenable = true
vim.opt.foldlevelstart=10
vim.opt.foldnestmax=10
vim.opt.foldmethod="indent"

vim.opt.splitbelow = true
vim.opt.hidden = true

vim.opt.spell = true
vim.opt.spelllang="en_us"

-- " set listchars+=multispace:···+
-- " set listchars+=eol:↵
vim.opt.listchars = { trail = '·', tab = '» ', leadmultispace = '│   '}
vim.opt.completeopt=menu,menuone,noselect,noinsert
vim.opt.list = true
vim.opt.updatetime=100

-- Netrw stuff
vim.g.netrwy_liststyle=3
vim.g.netrw_banner=0
