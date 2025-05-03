-- Syntax Highlighting for memory view plugin

vim.cmd("syn match MemoryVewAddress /^0x\\x\\{16}/")
vim.cmd('syn match MemoryViewNull " 0x00" skipwhite')
vim.cmd('syn match MemoryViewNonPrintableAscii " 0x0[123456789abcdefABCDEF]\\|0x1\\x" skipwhite')
-- vim.cmd('syn match MemoryViewAscii " [\\a\\A] "')
vim.cmd('syn match MemoryViewHighBytes " 0x7F\\|0x[89abcdefABCDEF]\\x" skipwhite')
-- Links
vim.cmd('hi default link MemoryVewAddress Comment')
vim.cmd('hi default link MemoryViewNull Conditional')
vim.cmd('hi default link MemoryViewNonPrintableAscii Type')
-- vim.cmd('hi default link MemoryViewAscii Text')
vim.cmd('hi default link MemoryViewHighBytes Operator')

