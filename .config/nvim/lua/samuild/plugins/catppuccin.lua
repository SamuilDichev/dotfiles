return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = false,
            integrations = {
                notify = true,
            },
        })

        vim.cmd([[colorscheme catppuccin]])
    end,
}
