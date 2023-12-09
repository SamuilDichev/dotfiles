local M = {}

-- General
vim.keymap.set("n", ";", ":")

-- tmux-navigator plugin overwrites these
-- vim.keymap.set("i", "<C-h>", "<Left>")                                                   -- Regular movement but in insert mode
-- vim.keymap.set("i", "<C-j>", "<Down>")                                                   -- ^
-- vim.keymap.set("i", "<C-k>", "<Up>")                                                     -- ^
-- vim.keymap.set("i", "<C-l>", "<Right>")                                                  -- ^

vim.keymap.set("n", "<C-h>", "<C-w>h")                                                   -- Move between windows/splits
vim.keymap.set("n", "<C-j>", "<C-w>j")                                                   -- ^
vim.keymap.set("n", "<C-k>", "<C-w>k")                                                   -- ^
vim.keymap.set("n", "<C-l>", "<C-w>l")                                                   -- ^

vim.keymap.set("n", "n", "nzzzv")                                                        -- next match and center the view
vim.keymap.set("n", "N", "Nzzzv")                                                        -- ^
vim.keymap.set("v", "<leader>y", '"+y')                                                  -- copy selection to system clipboard (as opposed to vim clipboard)
vim.keymap.set("n", "<leader>Y", '"+Y')                                                  -- copy line to system clipboard (as opposed to vim clipboard)
vim.keymap.set("n", "<leader>d", '"_d')                                                  -- blackhole delete (no cut, i.e. doesn't overwrite clipboard)
vim.keymap.set("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')                                -- don't copy on replacing text
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])           -- replace word under cursor
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- edit work under cursor
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")                                             -- move selection
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")                                             -- ^
vim.keymap.set("v", "H", "dhPgvhoho")                                                    -- ^
vim.keymap.set("v", "L", "dlPgvlolo")                                                    -- ^
vim.keymap.set("v", "<Tab>", ">gv")                                                      -- indent selection
vim.keymap.set("v", "<S-Tab>", "<gv")                                                    -- ^

-- LSP keymap - imported by lspconfig, sets keymap only if an LSP is loaded in a given buffer, otherwise remains unset
M.add_lsp_keymap_to_buffer = function(bufnr)
    local opts = { buffer = bufnr, remap = false }
    local trouble = require("trouble")

    vim.keymap.set({ "n", "v" }, "<leader>fm", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", function() trouble.toggle "lsp_references" end, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set({ "n", "i" }, "<C-g>", vim.lsp.buf.signature_help, opts)

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts)
end

-- Nvim Tree (file browser)
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")

-- Tabs
vim.keymap.set("n", "<Tab>", "<cmd> BufferNext<CR>") -- cycle tabs
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferPrevious<CR>")
vim.keymap.set("n", "<leader><Tab>", "<cmd> BufferPick<CR>")
vim.keymap.set("n", "]b", "<cmd> BufferMoveNext<CR>")     -- move curr tab
vim.keymap.set("n", "[b", "<cmd> BufferMovePrevious<CR>") -- ^
vim.keymap.set("n", "<leader>x", "<cmd> confirm BufferClose<CR>")
vim.keymap.set("n", "<leader>X", "<cmd> BufferRestore<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
vim.keymap.set("n", "<leader>fa", "<cmd> Telescope live_grep <CR>")
vim.keymap.set("n", "<leader>fg", "<cmd> Telescope git_status <CR>")  -- git diff
vim.keymap.set("n", "<leader>fc", "<cmd> Telescope git_commits <CR>")  -- git commits
vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
vim.keymap.set("n", "<C-f>", "<cmd> Telescope current_buffer_fuzzy_find <CR>")

-- Undo Tree
vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>")

-- Quickfix and location lists (need populating by something)
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz")

-- Trouble (diagnostics)
vim.keymap.set("n", "F2", function() require("trouble").toggle "document_diagnostics" end)

-- Comment
vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- todo-comments
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end) -- move between TODOs
vim.keymap.set("n", "[t", function() require("todo-comments").jump_next() end) -- ^

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

return M
