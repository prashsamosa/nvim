-- This plugin provides smart commenting functionality
-- Similar to VSCode's line/block comment toggle
return {
    'numToStr/Comment.nvim',
    -- Enable the plugin immediately on startup for all filetypes
    lazy = false,
    -- Configure with default options - no special configuration needed
    opts = {},
    -- Add a description for better discoverability
    desc = "Smart code commenting functionality"
}