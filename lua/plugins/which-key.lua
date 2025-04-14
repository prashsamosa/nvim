-- Configure 'which-key.nvim' for displaying keybinding hints in a popup.

return {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load the plugin lazily to improve startup time.

    init = function()
        -- Set timeout options for multi-key mappings.
        vim.o.timeout = true
        vim.o.timeoutlen = 500 -- Wait 500ms for the next key in a multi-key mapping.
    end,

    opts = {
        -- Add custom configuration here if needed.
        -- Leaving this table empty will use the plugin's default settings.
    },
}
