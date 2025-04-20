-- Configure 'nvim-treesitter' for syntax highlighting, text objects, and more.

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",                             -- Auto-update parsers after installation.
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Tree-sitter text objects.
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "elixir",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vimdoc",
        "yaml",
        "sql",
      },

      -- Autoinstall missing parsers when entering buffer
      auto_install = true,

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
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
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
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })
  end,
}
