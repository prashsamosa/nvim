return {
  -- Compatibility module (lazy-loadable)
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },

  -- Main blink completion engine
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Common snippets
      "moyiz/blink-emoji.nvim",       -- Emoji completions
      "ray-x/cmp-sql",                -- SQL completions
    },
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-y>"] = { "accept", "fallback" }, -- Accept completion with Ctrl+y
        ["<C-e>"] = { "close", "fallback" },  -- Close completion with Ctrl+e
        ["<C-n>"] = { "next_item", "fallback" }, -- Next item with Ctrl+n
        ["<C-p>"] = { "prev_item", "fallback" }, -- Previous item with Ctrl+p 
      },
      appearance = {
        nerd_font_variant = "mono", -- Use mono-styled Nerd Font icons
      },
      completion = {
        documentation = {
          auto_show = true, -- Show documentation popup automatically
        },
      },
      signature = {
        enabled = true, -- Show function signatures
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "sql" },

        providers = {
          -- Emoji source (only for markdown/gitcommit files)
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.bo.filetype)
            end,
          },

          -- SQL source (only for SQL files)
          sql = {
            module = "blink.compat.source",
            name = "sql",
            score_offset = -3,
            opts = {},
            should_show_items = function()
              return vim.tbl_contains({ "sql" }, vim.bo.filetype)
            end,
          },
        },
      },
      -- Prefer Rust fuzzy matching if available
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
    opts_extend = { "sources.default" },
  },
}
