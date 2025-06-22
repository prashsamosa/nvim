return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages to install
        ensure_installed = {
          "bash", "c", "cpp", "css", "elixir", "go", "html", "javascript",
          "json", "lua", "markdown", "markdown_inline", "python", "regex",
          "rust", "sql", "tsx", "typescript", "vimdoc", "yaml",
        },
        auto_install = true,

        -- Syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Indentation based on treesitter
        indent = { enable = true },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>",
            node_incremental = "<Enter>",
            scope_incremental = "<S-Enter>",
            node_decremental = "<BS>",
          },
        },

        -- Text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = "@scope",
              ["ao"] = "@comment.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
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
        },
      })
    end,
  }
