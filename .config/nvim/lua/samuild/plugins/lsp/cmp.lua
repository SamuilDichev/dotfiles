return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "L3MON4D3/LuaSnip" },
    },
    config = function()
        -- Here is where you configure the autocompletion settings.
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_cmp()

        -- And you can configure cmp even more, if you want to.
        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                ['<cr>'] = cmp.mapping.confirm({ select = true }),
            })
        })
    end
}
