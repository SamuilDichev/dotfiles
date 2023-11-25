return {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
        require("auto-session").setup({
            pre_save_cmds = { "tabdo NvimTreeClose" },
            cwd_change_handling = {
                post_cwd_changed_hook = function()
                    require("lualine").refresh()
                end,
            }
        })
    end,
}
