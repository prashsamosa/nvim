return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",

    config = function()
        local function lsp_client_names()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if vim.tbl_isempty(clients) then return "" end

            local names = {}
            for _, client in ipairs(clients) do
                if client.name then
                    table.insert(names, client.name)
                end
            end
            return #names > 0 and "󰒍 " .. table.concat(names, ", ") or ""
        end

        require("lualine").setup({
            options = {
                theme = "github_dark",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "branch", icon = "" },
                    { "diff",   symbols = { added = " ", modified = " ", removed = " " } },
                },
                lualine_c = {
                    { "filetype", icon_only = true, separator = "",      padding = { left = 1, right = 0 } },
                    { "filename", path = 1,         shorting_target = 40 },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    },
                    { lsp_client_names, cond = function() return not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 })) end },
                    "encoding",
                    "fileformat",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = { "lazy", "mason", "oil" },
        })
    end,
}
