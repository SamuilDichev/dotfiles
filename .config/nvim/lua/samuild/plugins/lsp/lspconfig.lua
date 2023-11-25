return {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "tsserver", "pyright" },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    -- (Optional) Configure lua language server for neovim
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
                pyright = function()
                    require("lspconfig").pyright.setup({
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
                end,
            }
        })

        local null_ls = require("null-ls")
        local null_opts = lsp_zero.build_options("null-ls", {})

        null_ls.setup({
            on_attach = function(client, bufnr)
                null_opts.on_attach(client, bufnr)
            end,
            sources = {
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length", "120" },
                }),
            }
        })
    end
}
