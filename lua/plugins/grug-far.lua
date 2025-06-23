-- lua/plugins/grug-far.lua
return {
    "MagicDuck/grug-far.nvim",
    -- Using a command is a good way to lazy-load the plugin
    cmd = "GrugFar",
    -- We must specify fzf-lua as a dependency to ensure it's loaded
    -- and that grug-far knows it can use it as a UI backend.
    dependencies = { "ibhagwan/fzf-lua" },
    keys = {
        -- I chose <leader>fR for "Find & Replace" to avoid conflicts with your existing keys.
        {
            "<leader>fR",
            function()
                require("grug-far").grug_far()
            end,
            desc = "Find and Replace (Grug-Far)",
        },
    },
    config = function()
        -- This is the most important part for integration:
        -- We tell grug-far to use fzf-lua as its user interface.
        require("grug-far").setup({
            backend = "fzf-lua", -- Use fzf-lua for the UI
            -- You can add other configurations here if needed
        })
    end,
}
