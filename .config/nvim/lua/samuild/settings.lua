-- swap/undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- do NOT ignore case if pattern has uppercase characters

-- Visual stuff
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.wrap = true
vim.opt.scrolloff = 8 -- scrolling doesn't hide all lines
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Sessions
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Performance
vim.opt.updatetime = 50

-- Indent
-- vim.opt.list = true
-- vim.opt.listchars:append("space:·")
vim.g.pyindent_open_paren = "shiftwidth()"

-- Fold
-- vim.o.foldcolumn = "1"  -- show folds in side column
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
