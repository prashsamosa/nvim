-- Plugin: numToStr/Comment.nvim
return {
  "numToStr/Comment.nvim",
  -- Load plugin before reading/creating a buffer for immediate use.
  event = { "BufReadPre", "BufNewFile" },

  -- Required for intelligent commenting in mixed-language files.
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    comment.setup({
      -- Use nvim-ts-context-commentstring to determine the correct comment
      -- style based on the syntax context (e.g., for JSX, TSX, HTML).
      pre_hook = ts_context_commentstring.create_pre_hook(),

      -- Uncomment and modify 'mapping' if you wish to override default keymaps.
      -- mapping = {
      --   basic = false, -- Disable default 'gc' mappings
      --   extra = {
      --     line = "gcc",  -- Line comment toggle (default)
      --     block = "gbc", -- Block comment toggle (default)
      --   },
      -- },
    })
  end,
}
