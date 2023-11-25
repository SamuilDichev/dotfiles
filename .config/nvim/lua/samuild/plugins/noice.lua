return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    lazy = false,
    config = function()
        require("noice").setup {
            presets = {
                command_palette = true,
                inc_rename = true,
                -- bottom_search = true,
            },
            routes = {
                {
                    -- hide "written" messages
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                -- Show notification when starting macro recording
                -- {
                --   view = "notify",
                --   filter = { event = "msg_showmode" },
                -- },
            },
            lsp = {
                hover = {
                    enabled = false,
                },
                signature = {
                    enabled = false,
                },
            },
        }
    end,
}
