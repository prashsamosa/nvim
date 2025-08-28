return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "nvim-treesitter/nvim-treesitter-textobjects",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash", "go", "html", "javascript", "json", "lua", "python",
        "rust", "tsx", "typescript", "vim", "vimdoc", "yaml", "sql",
        "dockerfile", "gitignore", "toml", "markdown", "markdown_inline"
      },
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          local max_filesize = 250 * 1024 -- 250KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
          return vim.api.nvim_buf_line_count(buf) > 10000
        end,
      },

      indent = { enable = true, disable = { "python" } },

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
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { ["]m"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_previous_start = { ["[m"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      },
    })
  end,
}
