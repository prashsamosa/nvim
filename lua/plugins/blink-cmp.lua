return {
  {
    "saghen/blink.compat",
    version = "*", -- Consider a more specific version for stability.
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "ray-x/cmp-sql",
    },
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
        ["<C-Z>"] = { "accept", "fallback" }, -- Accept completion or fallback to default behavior.
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true }, -- Automatically show documentation for selected completion item.
      },
      signature = { enabled = true }, -- Enable function signature help.
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "sql" }, -- Default sources for completion.
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype) -- Show emoji completions in git commit and markdown files.
            end,
          },
          sql = {
            name = "sql",
            module = "blink.compat.source",
            score_offset = -3,
            opts = {},
            should_show_items = function()
              return vim.tbl_contains({ "sql" }, vim.o.filetype) -- Show SQL completions in SQL files.
            end,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" }, -- Extend the default sources with additional configurations.
  },
}