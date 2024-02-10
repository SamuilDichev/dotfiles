return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" }, -- source
        { "hrsh7th/cmp-buffer" },   -- source
        { "hrsh7th/cmp-path" },     -- source
        { "hrsh7th/cmp-cmdline" },  -- source
        { "onsails/lspkind.nvim" }, -- icons in completion dropdown
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require("lspkind")
        local mapping = require("samuild.keymap").add_lsp_suggestion_keymap(cmp)

        -- Completion global settings
        cmp.setup({
            formatting = {
                format = lspkind.cmp_format({}),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'copilot' },
                -- { name = "treesitter" },
                { name = "buffer" },
                { name = 'path' },
            },
            mapping = cmp.mapping.preset.insert(mapping)
        })

        -- Specify sources for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Specify sources for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' },
            })
        })
    end
}
