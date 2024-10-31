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
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "ruff",
                "ruff_lsp",
                -- "rust_analyzer",
                -- "gopls@v0.11.0", -- For Golang version 1.16.15
            }
        })

        -- Auto-install formatters
        local formatters = { "prettierd", }
        local mason_registry = require("mason-registry")
        for _, formatter in ipairs(formatters) do
            local package = mason_registry.get_package(formatter)
            if not package:is_installed() then
                package:install()
            end
        end

        -- Servers with default setup
        -- local default_setup_servers = { "ts_ls", "rust_analyzer", "gopls" }
        local default_setup_servers = { "ts_ls", "ruff" }
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
                        -- ignore = { '*' }, -- disable analysis
                    }
                }
            },
        })

        lspconfig.ruff_lsp.setup {
            on_attach = function(client, bufnr)
                if client.name == 'ruff_lsp' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end,
            init_options = {
                settings = {
                    -- Any extra CLI arguments for `ruff` go here.
                    args = {},
                }
            }
        }

        -- For inline diagnostics - show only first line of the message
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    return diagnostic.message:match("^[^\n]*")
                end,
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
