return {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = {
                transparent = true,
                terminal_colors = true,
                dim_inactive = false,
                hide_end_of_buffer = true,
                hide_nc_statusline = true,

                styles = {
                    comments = "italic",
                    functions = "bold",
                    keywords = "italic",
                    types = "bold",
                },

                inverse = {
                    match_paren = true,
                    visual = false,
                    search = true,
                },

                darken = {
                    floats = true,
                    sidebars = { enable = true, list = { "neo-tree", "qf", "help" } },
                },

                modules = {
                    cmp = true,
                    dap = true,
                    gitsigns = true,
                    mini = true,
                    native_lsp = true,
                    notify = true,
                    treesitter = true,
                },
            },
        })

        vim.cmd("colorscheme github_dark_default")

        local hl = vim.api.nvim_set_hl
        local transparent_groups = {
            "Normal", "NormalNC", "NormalFloat", "FloatBorder",
            "Pmenu", "PmenuSbar", "PmenuThumb",
        }

        for _, group in ipairs(transparent_groups) do
            hl(0, group, { bg = "none" })
        end

        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "github_*",
            callback = function()
                for _, group in ipairs(transparent_groups) do
                    hl(0, group, { bg = "none" })
                end
            end,
        })
    end,
}
