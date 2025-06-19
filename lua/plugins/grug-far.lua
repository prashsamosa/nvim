return {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({
        -- You can override default options here.
        -- Default engine: "ripgrep"; options include "astgrep", "astgrep-rules".
      })
    end,
  }
