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
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = { "filename" },
                lualine_x = {
                    "diagnostics",
                    { lsp_client_names, cond = function() return not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 })) end },
                    "encoding",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        })
    end,
}
