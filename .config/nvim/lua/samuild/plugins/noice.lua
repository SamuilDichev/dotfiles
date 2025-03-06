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
                long_message_to_split = true,
            },
            routes = {
                -- hide messages containing these strings
                { filter = { event = "msg_show", kind = "", find = "written", },          opts = { skip = true } },
                { filter = { event = "msg_show", kind = "", find = "%d+ more line", },    opts = { skip = true } },
                { filter = { event = "msg_show", kind = "", find = "%d+ fewer lines", },  opts = { skip = true } },
                { filter = { event = "msg_show", kind = "", find = "%d+ lines yanked", }, opts = { skip = true } },
            },
            lsp = {
                -- hover = {
                --     enabled = true,
                -- },
                -- signature = {
                --     enabled = true,
                -- },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    -- ["cmp.entry.get_documentation"] = true,
                    -- ["vim.lsp.handlers.hover"] = true,
                    -- ["vim.lsp.handlers.signature_help"] = true,
                },
            },
        }
    end,
}
