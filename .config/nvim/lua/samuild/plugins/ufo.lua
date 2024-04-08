return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    lazy = false,
    config = function()
        require("ufo").setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "lsp", "indent" }
            end
        })
    end
}
