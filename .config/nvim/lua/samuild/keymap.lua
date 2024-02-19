local M = {}

-- General
vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "L", "$", { desc = "Move to END of line" })
vim.keymap.set("n", "H", "^", { desc = "Move to START of line" })

-- vim.keymap.set("i", "<C-h>", "<Left>")  -- Regular movement but in insert mode
-- vim.keymap.set("i", "<C-j>", "<Down>")  -- ^
-- vim.keymap.set("i", "<C-k>", "<Up>")    -- ^
-- vim.keymap.set("i", "<C-l>", "<Right>") -- ^

vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Movement + Center view
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- ^
vim.keymap.set("n", "{", "{zz")         -- ^
vim.keymap.set("n", "}", "}zz")         -- ^
vim.keymap.set("n", "G", "Gzz")         -- ^
vim.keymap.set("n", "<C-i>", "<C-i>zz") -- ^
vim.keymap.set("n", "<C-o>", "<C-o>zz") -- ^
vim.keymap.set("n", "n", "nzzzv")       -- ^
vim.keymap.set("n", "N", "Nzzzv")       -- ^

-- tmux-navigator plugin overwrites these
-- vim.keymap.set("n", "<C-h>", "<C-w>h")                                                   -- Move between windows/splits
-- vim.keymap.set("n", "<C-j>", "<C-w>j")                                                   -- ^
-- vim.keymap.set("n", "<C-k>", "<C-w>k")                                                   -- ^
-- vim.keymap.set("n", "<C-l>", "<C-w>l")                                                   -- ^

vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete w/o copy" })
vim.keymap.set("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste and replace without copy" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = "Replace under cursor" })
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Edit under cursor" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- LSP keymap - imported by lspconfig, sets keymap only if an LSP is loaded in a given buffer, otherwise remains unset
M.add_lsp_keymap_to_buffer = function(bufnr)
    local function opts(desc) return { buffer = bufnr, remap = false, desc = desc } end

    vim.keymap.set({ "n", "v" }, "<leader>fm", vim.lsp.buf.format, opts("[LSP] Format"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("[LSP] Go to definition"))
    vim.keymap.set("n", "gr", function() require("trouble").toggle "lsp_references" end, opts("[LSP] References"))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("[LSP] Next diagnostic"))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("[LSP] Previous diagnostic"))

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("[LSP] Hover"))
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts("[LSP] Signature help"))

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("[LSP] Code action"))
    vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts("[LSP] Rename"))
end

-- LSP keymap for suggestions drop-down - imported by cmp config
M.add_lsp_suggestion_keymap = function(cmp)
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    return {
        -- ['<C-Space>'] = cmp.mapping.complete(), -- starts auto-completing
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select), -- cycle back through suggestions
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),   -- cycle forward through suggestions
        ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        }),
    }
end

-- Marks/bookmarks mappings
M.marks_mappings = {
    set = "m",            -- Waits for 1 char input, sets a mark with that name
    delete = "dm",        -- Waits for 1 char input, deletes a mark with that name
    toggle = "<leader>m", -- Toggles a mark at cursor using the next available name (self-assigns name)
    next = "]m",
    prev = "[m",
    delete_line = "dm.",    -- Deletes all marks on current line
    delete_buf = "dm<tab>", -- Deletes all marks in current buffer
}

-- Nvim Tree (file browser)
vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle file browser" })
vim.keymap.set("n", "<F1>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle file browser" })

-- Tabs
vim.keymap.set("n", "<Tab>", "<cmd> BufferNext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferPrevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader><Tab>", "<cmd> BufferPick<CR>", { desc = "Pick tab by letter" })
vim.keymap.set("n", "]b", "<cmd> BufferMoveNext<CR>", { desc = "Move tab forward" })
vim.keymap.set("n", "[b", "<cmd> BufferMovePrevious<CR>", { desc = "Move tab backward" })
vim.keymap.set("n", "<leader>x", "<cmd> confirm BufferClose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>X", "<cmd> BufferRestore<CR>", { desc = "Restore closed tab" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "[Telescope] Find files" })
vim.keymap.set("n", "<leader>fa", "<cmd> Telescope live_grep <CR>", { desc = "[Telescope] Grep ALL files" })
vim.keymap.set("n", "gs", "<cmd> Telescope git_status <CR>", { desc = "[Telescope] Git diff" })
vim.keymap.set("n", "gc", "<cmd> Telescope git_commits <CR>", { desc = "[Telescope] Git commits" })
vim.keymap.set("n", "<F2>", "<cmd> Telescope marks <CR>", { desc = "[Telescope] Marks" })
vim.keymap.set("n", "<F4>", "<cmd> Telescope notify <CR>", { desc = "[Telescope] Notifications" })
vim.keymap.set("n", "<F5>", "<cmd> Telescope help_tags <CR>", { desc = "[Telescope] Help tags" })

-- Undo Tree
vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>", { desc = "Toggle undo tree" })

-- Quickfix and location lists (need populating by something)
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next in loc list" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz", { desc = "Previous in loc list" })

-- Trouble (diagnostics)
vim.keymap.set("n", "<F3>", function() require("trouble").toggle "document_diagnostics" end, { desc = "Diagnostics" })

-- Comment
vim.keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- todo-comments
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_next() end, { desc = "Previous todo" })

-- gitsigns
vim.keymap.set("n", "]c",
    function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() require("gitsigns").next_hunk() end)
        return "<Ignore>"
    end,
    { desc = "Next git hunk" }
)

vim.keymap.set("n", "[c",
    function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() require("gitsigns").prev_hunk() end)
        return "<Ignore>"
    end,
    { desc = "Previous git hunk" }
)

vim.keymap.set("n", "rh", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
vim.keymap.set("n", "td", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle deleted" })
vim.keymap.set("n", "gb", function() package.loaded.gitsigns.blame_line() end, { desc = "Blame line" })
-- vim.keymap.set("n", "ph", function() require("gitsigns").preview_hunk() end)

return M
