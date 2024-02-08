-- swap/undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

-- Incremental search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Visual stuff
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.wrap = true
vim.opt.scrolloff = 8 -- scrolling doesn't hide all lines
vim.opt.colorcolumn = "120"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.o.splitbelow = true

-- Sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Performance
vim.opt.updatetime = 50

-- Indent
-- vim.opt.list = true
-- vim.opt.listchars:append("space:·")
vim.g.pyindent_open_paren = "shiftwidth()"
