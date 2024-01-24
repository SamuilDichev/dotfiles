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
        -- local cmp_action = lsp_zero.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                -- ['<C-Space>'] = cmp.mapping.complete(), -- starts auto-completing
                ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select), -- cycle back through suggestions
                ['<Tab>'] = cmp.mapping.select_next_item(cmp_select), -- cycle forward through suggestions
                ['<cr>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                }),
            })
        })
    end
}
