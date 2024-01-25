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
        local custom_keymap = require("samuild.keymap")
        local mapping = custom_keymap.add_lsp_suggestion_keymap(cmp)

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert(mapping)
        })
    end
}
