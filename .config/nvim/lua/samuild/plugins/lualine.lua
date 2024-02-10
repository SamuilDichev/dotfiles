return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function get_macro_recording()
            if vim.fn.reg_recording() == "" then
                return ""
            end

            return " " .. vim.fn.reg_recording()
        end

        local function show_active_lsp()
            local msg = "NO LSP ACTIVE"
            local buf_ft = vim.api.nvim_get_option_value("filetype", {})
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end

            local client_names = {}
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    table.insert(client_names, client.name)
                end
            end
            return table.concat(client_names, " & ")
        end

        require("lualine").setup {
            options = {
                globalstatus = true,
                disabled_filetypes = { "NvimTree" },
            },
            sections = {
                lualine_c = {
                    require("auto-session.lib").current_session_name,
                    {
                        "macro-recording",
                        fmt = get_macro_recording,
                        color = { fg = "red" },
                    },
                },
                lualine_x = {
                    "fileformat",
                    {
                        "lsp",
                        fmt = show_active_lsp,
                        icon = "'",
                    },
                    "filetype",
                },
            },
        }
    end,
}
