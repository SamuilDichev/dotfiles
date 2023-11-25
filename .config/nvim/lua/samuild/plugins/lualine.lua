return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("lualine").setup {
            options = {
                globalstatus = true,
                disabled_filetypes = { "NvimTree" },
            },
            sections = { lualine_c = { require("auto-session.lib").current_session_name } },
        }
    end,
}
