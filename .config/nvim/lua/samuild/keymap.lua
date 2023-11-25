-- LSP (there are more LSP keymaps in the lsp config)
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("v", "<leader>fm", vim.lsp.buf.format)

-- General
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "n", "nzzzv")                                                        -- next match and center view
vim.keymap.set("n", "N", "Nzzzv")                                                        -- prev match and center view
vim.keymap.set("v", "<leader>y", '"+y')                                                  -- copy selection to system clipboard (as opposed to vim clipboard)
vim.keymap.set("n", "<leader>Y", '"+Y')                                                  -- copy current line to system clipboard (as opposed to vim clipboard)
vim.keymap.set("n", "<leader>d", '"_d')                                                  -- blackhole delete (no cut, i.e. doesn't overwrite clipboard)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])           -- replace word under cursor
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- edit work under cursor
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")                                             -- move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")                                             -- move selection up
vim.keymap.set("v", "H", "dhPgvhoho")                                                    -- move selection left
vim.keymap.set("v", "L", "dlPgvlolo")                                                    -- move selection right
vim.keymap.set("v", "<Tab>", ">gv")                                                      -- indent >
vim.keymap.set("v", "<S-Tab>", "<gv")                                                    -- indent <

-- Nvim Tree (file browser)
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")

-- Tabs
vim.keymap.set("n", "<Tab>", "<cmd> BufferNext<CR>") -- cycle
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferPrevious<CR>")
vim.keymap.set("n", "<leader><Tab>", "<cmd> BufferPick<CR>")
vim.keymap.set("n", "]b", "<cmd> BufferMoveNext<CR>")     -- move curr tab to the right
vim.keymap.set("n", "[b", "<cmd> BufferMovePrevious<CR>") -- move curr tab to the left
vim.keymap.set("n", "<C-w>", "<cmd> BufferClose<CR>")
vim.keymap.set("n", "<leader>x", "<cmd> BufferRestore<CR>")

-- Telescope
vim.keymap.set('n', '<leader>ff', "<cmd> Telescope find_files <CR>")
vim.keymap.set('n', '<leader>fg', "<cmd> Telescope git_files <CR>")
vim.keymap.set('n', '<C-f>', "<cmd> Telescope live_grep <CR>")
vim.keymap.set('n', '<leader>fb', "<cmd> Telescope buffers <CR>")
vim.keymap.set('n', '<leader>fh', "<cmd> Telescope help_tags <CR>")

-- Undo Tree
vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>")

-- Quickfix and location lists (need populating by something)
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz")

-- Trouble (diagnostics)
vim.keymap.set("n", "<leader>tt", "<cmd> TodoTrouble <CR>")
vim.keymap.set("n", "<leader>te", function() require("trouble").toggle "document_diagnostics" end)
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle "quickfix" end)
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle "loclist" end)
vim.keymap.set("n", "gr", function() require("trouble").toggle "lsp_references" end)

-- Comment
vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- todo-comments
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end) -- jump to next todo
vim.keymap.set("n", "[t", function() require("todo-comments").jump_next() end) -- jump to prev todo

-- gitsigns
vim.keymap.set("n", "]c",
    function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() require("gitsigns").next_hunk() end)
        return "<Ignore>"
    end
)

vim.keymap.set("n", "[c",
    function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() require("gitsigns").prev_hunk() end)
        return "<Ignore>"
    end
)

vim.keymap.set("n", "rh", function() require("gitsigns").reset_hunk() end)
vim.keymap.set("n", "td", function() require("gitsigns").toggle_deleted() end)
vim.keymap.set("n", "gb", function() package.loaded.gitsigns.blame_line() end)
vim.keymap.set("n", "ph", function() require("gitsigns").preview_hunk() end)
