return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- Removed nvim-ts-context-commentstring dependency as it's built into Neovim 0.10+
    config = function()
        local comment = require("Comment")

        comment.setup({
            -- Neovim 0.10+ has built-in treesitter context commentstring
            -- No need for external plugin
            pre_hook = nil, -- Remove the ts_context_commentstring integration
        })
    end,
}
