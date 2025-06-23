return {
  -- Optional Blink compatibility module
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
  },

  -- Blink completion engine
  {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = true, -- You could also use event = "InsertEnter"
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "ray-x/cmp-sql",
    },
    opts = function()
      -- Utility function: safely get current filetype
      local function get_filetype()
        local ok, ft = pcall(function() return vim.bo.filetype end)
        return ok and ft or ""
      end

      -- Utility function: returns closure to check filetype inclusion
      local function should_show_in(ft_list)
        return function()
          return vim.tbl_contains(ft_list, get_filetype())
        end
      end

      return {
        keymap = {
          preset = "default",
          ["<CR>"] = { "accept", "fallback" },
        },

        appearance = {
          nerd_font_variant = "mono",
        },

        completion = {
          documentation = {
            auto_show = true,
          },
        },

        signature = {
          enabled = true,
        },

        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
            "emoji",
            "sql",
          },

          providers = {
            emoji = {
              module = "blink-emoji",
              name = "Emoji",
              score_offset = 15,
              opts = { insert = true },
              should_show_items = should_show_in({ "gitcommit", "markdown" }),
            },

            sql = {
              module = "blink.compat.source",
              name = "sql",
              score_offset = -3,
              opts = {},
              should_show_items = should_show_in({ "sql" }),
            },
          },
        },

        fuzzy = {
          implementation = "prefer_rust_with_warning",
        },
      }
    end,

    opts_extend = { "sources.default" },
  },
}
