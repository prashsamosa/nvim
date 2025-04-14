-- Configure 'nvim-treesitter' for syntax highlighting, text objects, and more.

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Auto-update parsers after installation.
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Tree-sitter text objects.
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { -- Languages to install parsers for.
          "c", "lua", "vim", "vimdoc", "query",
          "elixir", "heex", "javascript", "html",
          "markdown", "markdown_inline", "latex",
          "json", "yaml", "toml", "css", "python",
          "typescript", "tsx", "bash", "regex",
        },
        auto_install = true,  -- Auto-install missing parsers.
        sync_install = false, -- Don't block startup.
        highlight = { enable = true }, -- Enable highlighting.
        indent = { enable = true },    -- Enable indentation.
  
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>",    -- Start selection.
            node_incremental = "<Enter>",  -- Expand selection.
            node_decremental = "<Backspace>", -- Shrink selection.
          },
        },
  
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Auto-jump to text object.
            keymaps = {
              ["af"] = "@function.outer", -- Outer function.
              ["if"] = "@function.inner", -- Inner function.
              ["ac"] = "@class.outer",    -- Outer class.
              ["ic"] = "@class.inner",    -- Inner class.
              ["ao"] = "@comment.outer",  -- Outer comment.
              ["as"] = "@scope",          -- Current scope.
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',   -- Charwise parameter.
              ['@function.outer'] = 'V',   -- Linewise function.
              ['@class.outer'] = '<c-v>', -- Blockwise class.
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner", -- Next parameter.
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner", -- Previous parameter.
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- Add to jumplist.
            goto_next_start = {
              ["]m"] = "@function.outer", -- Next function start.
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer", -- Next function end.
              ["]["] = "@class.outer",    -- Next class end.
            },
            goto_previous_start = {
              ["[m"] = "@function.outer", -- Previous function start.
              ["[["] = "@class.outer",  -- Previous class start.
            },
            goto_previous_end = {
              ["[M"] = "@function.outer", -- Previous function end.
              ["[]"] = "@class.outer",    -- Previous class end.
            },
          },
        },
      })
    end,
  }