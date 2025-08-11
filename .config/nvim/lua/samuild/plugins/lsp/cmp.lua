return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        { "L3MON4D3/LuaSnip" },             -- snippets engine
        { "saadparwaiz1/cmp_luasnip" },     -- snippets source
        { "rafamadriz/friendly-snippets" }, -- snippets

        { "hrsh7th/cmp-nvim-lsp" },         -- source
        { "hrsh7th/cmp-buffer" },           -- source
        { "hrsh7th/cmp-path" },             -- source
        { "hrsh7th/cmp-cmdline" },          -- source
        { "hrsh7th/cmp-nvim-lua" },         -- source

        { "onsails/lspkind.nvim" },         -- icons in completion dropdown
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require("lspkind")
        local mapping = require("samuild.keymap").add_lsp_suggestion_keymap(cmp)
        require("luasnip.loaders.from_vscode").lazy_load()

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
                        Supermaven = "ﲀ",
                    },
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- sorting = {
            --     priority_weight = 1.0,
            --     comparators = {
            --         cmp.config.compare.exact,
            --         cmp.config.compare.locality,
            --         cmp.config.compare.recently_used,
            --         cmp.config.compare.score,
            --         cmp.config.compare.offset,
            --         cmp.config.compare.order,
            --         -- cmp.config.compare.kind,
            --         -- cmp.config.compare.length,
            --         -- cmp.config.compare.scopes,
            --         -- cmp.config.compare.score_offset,
            --         -- cmp.config.compare.sort_text,
            --     },
            -- },
            sources = {
                { name = 'luasnip',  priority = 10 },
                { name = 'nvim_lsp', priority = 9 },
                { name = 'nvim_lua', priority = 5 },
                { name = "buffer",   priority = 4, keyword_length = 3, max_item_count = 3 },
                { name = 'path',     priority = 3 },
                -- { name = "treesitter" },
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
