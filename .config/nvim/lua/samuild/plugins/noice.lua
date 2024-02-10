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
            },
            routes = {
                -- hide messages containing these strings
                { filter = { event = "msg_show", kind = "", find = "written", }, opts = { skip = true } },
                { filter = { event = "msg_show", kind = "", find = "%d+ more line", }, opts = { skip = true } },
                { filter = { event = "msg_show", kind = "", find = "%d+ fewer lines", }, opts = { skip = true } },
            },
            lsp = {
                -- TODO: See if what I currently have is enough or if I need to find a way to use these
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
