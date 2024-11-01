return {
    -- "jose-elias-alvarez/null-ls.nvim", -- archived
    "nvimtools/none-ls.nvim", -- fork of null-ls
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        -- local isort = null_ls.builtins.formatting.isort
        -- local black = null_ls.builtins.formatting.black
        local ruff_lint = require("none-ls.formatting.ruff")
        local ruff_format = require("none-ls.formatting.ruff_format")
        local prettierd_format = require("null-ls.builtins.formatting.prettierd")

        local sources = {
            -- isort,
            -- black.with({ extra_args = { "--line-length", "120" } }),
            ruff_lint,
            ruff_format,
            prettierd_format,
        }

        null_ls.setup({ sources = sources })
    end
}
