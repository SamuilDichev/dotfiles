return {
    "romgrk/barbar.nvim",
    lazy = false,
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        focus_on_close = 'right',
        exclude_ft = { "fugitive" },
        icons = {
            -- diagnostics = {
            --     [vim.diagnostic.severity.ERROR] = { enabled = true },
            --     [vim.diagnostic.severity.WARN] = { enabled = true },
            --     [vim.diagnostic.severity.INFO] = { enabled = true },
            --     [vim.diagnostic.severity.HINT] = { enabled = true },
            -- },
            gitsigns = {
                added = { enabled = true },
                changed = { enabled = true },
                deleted = { enabled = true },
            },
        },
    },
}
