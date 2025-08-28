-- lua/plugins/blink-cmp.lua
return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },

  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-d>"] = { "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-space>"] = { "show", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        window = { max_width = 80, max_height = 20, border = "rounded" },
      },
      menu = {
        border = "rounded",
        scrollbar = true,
        draw = {
          columns = {
            { "kind_icon" },
            { "label",      "label_description", gap = 1 },
            { "source_name" }
          },
          treesitter = { "lsp" }
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
    },

    signature = {
      enabled = true,
      window = { border = "rounded" },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- Per-filetype configuration
      per_filetype = {
        lua = { "lsp", "path", "snippets", "buffer" },
        go = { "lsp", "path", "snippets", "buffer" },
        typescript = { "lsp", "path", "snippets", "buffer" },
        python = { "lsp", "path", "snippets", "buffer" },
      }
    },
  },

  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
}
