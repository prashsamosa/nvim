-- lua/plugins/treesitter.lua (Example Path)
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Run this command after installation to ensure parsers are updated
  dependencies = {
    -- Ensure this dependency is correctly specified if it's in a separate file
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      modules = {},     -- Required field, leave empty unless advanced usage
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
        "sql",
        "tsx",
        "typescript",
        "vimdoc",
        "yaml",
      },
      auto_install = true,      -- Automatically install missing parsers
      sync_install = false,     -- Do not block Neovim startup for parser installation
      ignore_install = {},      -- List of parsers to ignore installation for

      highlight = {
        enable = true,
        -- Set to false if Treesitter handles most highlighting to avoid conflicts/performance issues
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },     -- Enable indentation based on Treesitter

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
          lookahead = true,         -- Allows for textobjects that look forward/backward
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
            ["<leader>pa"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>pA"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true,         -- whether to set jumps in the jumplist
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
          floating_preview_opts = {},         -- Customize floating window options here
          peek_definition_code = {
            ["<leader>pf"] = "@function.outer",
            ["<leader>pc"] = "@class.outer",
            -- If you had a @table.outer textobject for Lua/other langs:
            -- ["<leader>pt"] = "@table.outer",
          },
        },
      },
    })

    -- Folding with treesitter
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false   -- Start with folds open (user preference)
  end,
}
