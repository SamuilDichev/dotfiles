return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function get_macro_recording()
            return vim.fn.reg_recording()
        end

        local function show_active_lsp()
            local buf_ft = vim.api.nvim_get_option_value("filetype", {})
            -- TODO: In earlier versions this was 'vim.lsp.buf_get_clients()', later becomes lsp.get_clients()
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return ""
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
                    {
                        require("auto-session.lib").current_session_name,
                        separator = "",
                    },
                    { "%=", separator = "" },
                    {
                        "macro-recording",
                        fmt = get_macro_recording,
                        icon = { "", color = { fg = "red" } },
                        separator = "",
                    },
                },
                lualine_x = {
                    "fileformat",
                    {
                        "lsp",
                        fmt = show_active_lsp,
                        icon = { "", color = { fg = "limegreen" } },
                    },
                    "filetype",
                },
            },
        }
    end,
}
