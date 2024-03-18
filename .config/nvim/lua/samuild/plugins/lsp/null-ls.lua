return {
    -- "jose-elias-alvarez/null-ls.nvim", -- archived
    "nvimtools/none-ls.nvim", -- fork of null-ls
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")
        local b = null_ls.builtins
        local sources = {
            b.formatting.isort,
            b.formatting.black.with({ extra_args = { "--line-length", "120" } }),
        }

        null_ls.setup({ sources = sources })
    end
}
