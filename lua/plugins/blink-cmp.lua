return {
  -- Optional Blink compatibility module (lazy-loaded)
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
  },

  -- Blink completion engine
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "ray-x/cmp-sql",
    },
    opts = {
      -- Key mappings for completion actions
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
      },

      -- UI appearance customization
      appearance = {
        nerd_font_variant = "mono",
      },

      -- Completion behavior settings
      completion = {
        documentation = {
          auto_show = true,
        },
      },

      -- Signature help during typing
      signature = {
        enabled = true,
      },

      -- Completion sources
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "emoji",
          "sql",
        },

        -- Custom providers with logic to limit filetypes
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.bo.filetype)
            end,
          },

          sql = {
            module = "blink.compat.source",
            name = "sql",
            score_offset = -3,
            opts = {},
            should_show_items = function()
              return vim.bo.filetype == "sql"
            end,
          },
        },
      },

      -- Fuzzy search implementation (Rust preferred)
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },

    -- Extend only the default sources (good practice)
    opts_extend = { "sources.default" },
  },
}
