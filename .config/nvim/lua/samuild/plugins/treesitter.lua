return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "python",
                "rust",
                "zig",
                "markdown",
                "markdown_inline",
                "regex",
                "bash",
            },
            sync_install = false,
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = {
                    "python",
                },
            },
        })
    end
}
