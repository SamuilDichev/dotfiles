return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        { "L3MON4D3/LuaSnip" },       -- source
        { "hrsh7th/cmp-nvim-lsp" },   -- source
        { "hrsh7th/cmp-buffer" },     -- source
        { "hrsh7th/cmp-path" },       -- source
        { "hrsh7th/cmp-cmdline" },    -- source
        { "zbirenbaum/copilot-cmp" }, -- source
        { "onsails/lspkind.nvim" },   -- icons in completion dropdown
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require("lspkind")
        local mapping = require("samuild.keymap").add_lsp_suggestion_keymap(cmp)
        require("copilot_cmp").setup({})

        -- Completion global settings
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.None,
            formatting = {
                format = lspkind.cmp_format({
                    symbol_map = {
                        Copilot = "",
                    },
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
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
