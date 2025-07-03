return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {}, -- Required field for treesitter
      ensure_installed = {
        "bash", "c", "cpp", "css", "elixir", "go", "html", "javascript",
        "json", "lua", "markdown", "markdown_inline", "python", "regex",
        "rust", "sql", "tsx", "typescript", "vimdoc", "yaml",
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Enter>",
          node_incremental = "<Enter>",
          scope_incremental = "<S-Enter>",
          node_decremental = "<BS>",
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["at"] = "@comment.outer",
            ["it"] = "@comment.inner",
            ["ad"] = "@conditional.outer",
            ["id"] = "@conditional.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["a="] = "@assignment.outer",
            ["i="] = "@assignment.inner",
            ["aq"] = "@call.outer",
            ["iq"] = "@call.inner",
          },
        },

        swap = {
          enable = true,
          swap_next = {
            -- CORRECTED: Keymap now matches readme.md
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            -- CORRECTED: Keymap now matches readme.md
            ["<leader>A"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          -- CORRECTED: Movement keymaps now match readme.md
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[C"] = "@class.outer",
          },
        },

        lsp_interop = {
          enable = true,
          border = 'rounded',
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>pf"] = "@function.outer",
            ["<leader>pc"] = "@class.outer",
          },
        },
      },
    })

    -- Folding with treesitter
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false -- Start with folds open
  end,
}
