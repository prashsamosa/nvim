return {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
        require("github-theme").setup({
            options = {
                transparent = true,
                styles = {
                    comments = "italic",
                    functions = "bold",
                    keywords = "italic",
                },
            },
        })
        vim.cmd("colorscheme github_dark_default")
    end,
}
