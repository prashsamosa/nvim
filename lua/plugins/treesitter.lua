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
          -- Using different keymaps to avoid conflict with snacks.nvim scope (ii/ai)
          -- snacks.nvim uses ii/ai for scope-based text objects
          -- treesitter uses these for AST-based text objects
          keymaps = {
            -- Functions
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",

            -- Classes
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",

            -- Parameters/Arguments
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",

            -- Loops
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",

            -- Comments
            ["at"] = "@comment.outer",
            ["it"] = "@comment.inner",

            -- Conditionals
            ["ad"] = "@conditional.outer",
            ["id"] = "@conditional.inner",

            -- Blocks
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",

            -- Assignments
            ["a="] = "@assignment.outer",
            ["i="] = "@assignment.inner",

            -- Calls
            ["aq"] = "@call.outer",
            ["iq"] = "@call.inner",
          },
        },

        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner",
            ["<leader>sf"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
            ["<leader>sF"] = "@function.outer",
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]a"] = "@parameter.inner",
            ["]l"] = "@loop.outer",
            ["]e"] = "@conditional.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]A"] = "@parameter.inner",
            ["]L"] = "@loop.outer",
            ["]D"] = "@conditional.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[a"] = "@parameter.inner",
            ["[l"] = "@loop.outer",
            ["[e"] = "@conditional.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[A"] = "@parameter.inner",
            ["[L"] = "@loop.outer",
            ["[D"] = "@conditional.outer",
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
