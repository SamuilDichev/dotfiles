vim.g.mapleader = " "
require "samuild.settings"
require "samuild.keymap"
require "samuild.plugin_manager"

-- When leaving Telescope window, return to normal mode (otherwise might remain in insert mode)
vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.highlight.on_yank { timeout = 200, visual = true }
    end,
})

-- Set colorcolumn to 100 for Python files
-- Could also use a python.lua file at after/ftplugin but needs to be in root
-- dir which doesn't work for my config structure
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.cmd("setlocal colorcolumn=100")
    end,
})
