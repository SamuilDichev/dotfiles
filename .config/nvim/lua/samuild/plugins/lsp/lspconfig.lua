return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "folke/trouble.nvim" },
    },
    config = function()
        local custom_keymap = require("samuild.keymap")
        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        require("mason").setup({})
        require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "tsserver", "pyright", "rust_analyzer" } })

        -- Servers with default setup
        local default_setup_servers = { "tsserver", "rust_analyzer" }
        for _, server in ipairs(default_setup_servers) do
            lspconfig[server].setup({ capabilities = capabilities })
        end

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        -- Servers with special setup
        lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
                disableOrganizeImports = true,
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                        autoImportCompletions = true,
                        autoFormatStrings = true, -- Place f in front of strings when you type { inside one
                    }
                }
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local bufnr = ev.buf
                vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                custom_keymap.add_lsp_keymap_to_buffer(bufnr)
            end,
        })
    end
}
