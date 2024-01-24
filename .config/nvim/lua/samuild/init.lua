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
