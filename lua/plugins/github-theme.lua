return {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = {
                compile_path = vim.fn.stdpath("cache") .. "/github-theme",
                compile_file_suffix = "_compiled",

                -- Appearance
                transparent = false,
                terminal_colors = true,
                dim_inactive = false, -- ✅ Important: disables weird split coloring
                hide_end_of_buffer = true,
                hide_nc_statusline = true,

                -- Styling
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
                    sidebars = {
                        enable = true,
                        list = { "neo-tree", "qf", "help" },
                    },
                },

                modules = {
                    lsp_trouble = true,
                    cmp = true,
                    gitsigns = true,
                    treesitter = true,
                    telescope = true,
                    dap = true,
                    native_lsp = true,
                },
            },
        })

        -- Set the colorscheme safely
        local ok, _ = pcall(vim.cmd, "colorscheme github_dark_default")
        if not ok then
            vim.notify("Colorscheme 'github_dark_default' not found!", vim.log.levels.WARN)
            return
        end

        -- Optional: Transparent floats and inactive windows
        local hl = vim.api.nvim_set_hl
        hl(0, "Normal", { bg = "none" })
        hl(0, "NormalNC", { bg = "none" }) -- inactive windows
        hl(0, "NormalFloat", { bg = "none" }) -- floating windows
        hl(0, "FloatBorder", { bg = "none" })
        hl(0, "TelescopeNormal", { bg = "none" })
        hl(0, "TelescopeBorder", { bg = "none" })
        hl(0, "Pmenu", { bg = "none" }) -- completion menu
    end,
}
