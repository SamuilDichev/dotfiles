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
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "ruff",
                -- "ruff_lsp",  -- deprecated in favor of just "ruff"
                -- "volar",
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
        -- local default_setup_servers = { "ruff", }
        -- for _, server in ipairs(default_setup_servers) do
        --     lspconfig[server].setup({ capabilities = capabilities })  -- deprecated, use vim.lsp.config
        -- end

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
        vim.lsp.enable({"lua_ls"})

        -- Servers with special setup
        vim.lsp.config("pyright", {
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
        vim.lsp.enable({"pyright"})

        vim.lsp.config("ruff", {
            on_attach = function(client, bufnr)
                if client.name == "ruff" then
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
        })
        vim.lsp.enable({"ruff"})

        -- vim.lsp.config("volar", {
        --     capabilities = capabilities,
        --     -- init_options = {
        --     --     vue = {
        --     --         hybridMode = false,
        --     --     },
        --     -- },
        --     filetypes = { "vue" },
        --     on_attach = function(client)
        --         -- Disable formatting, leave it to prettier
        --         client.server_capabilities.documentFormattingProvider = false
        --         client.server_capabilities.documentRangeFormattingProvider = false
        --     end,
        -- })
        -- vim.lsp.enable({"volar"})

        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            init_options = {
                -- Used to require:
                -- npm install -g @vue/language-server
                -- npm install -g @vue/typescript-plugin
                -- Currently using exclusively via Mason so the above shouldn't be needed
                plugins = {
                    {
                        -- seems to only work with typescript 5+
                        name = "@vue/typescript-plugin",
                        location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                        languages = { "vue", },
                    },
                },
            },
        })
        vim.lsp.enable({"ts_ls"})

        vim.diagnostic.config({
            -- inline diagnostics
            virtual_text = {
                -- show only first line of the message
                format = function(diagnostic)
                    return diagnostic.message:match("^[^\n]*")
                end,
            },
            -- floating diagnostics
            float = {
                -- show lsp
                source = true,
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local bufnr = ev.buf
                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                custom_keymap.add_lsp_keymap_to_buffer(bufnr)
            end,
        })
    end
}
