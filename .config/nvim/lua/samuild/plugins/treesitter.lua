return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = 'master',
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
                "vue",
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
                enable = false,
                disable = {
                    "python",
                },
            },
        })
    end
}
