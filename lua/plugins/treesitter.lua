return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = "nvim-treesitter/nvim-treesitter-textobjects",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash", "go", "html", "javascript", "json", "lua",
        "python", "rust", "tsx", "typescript", "vim", "vimdoc",
        "yaml", "sql", "dockerfile", "gitignore",
        -- Add these modern parsers
        "toml", "graphql", "prisma", "astro", "svelte", "templ",
        "just", "nu", "zig", "odin",
      },
      auto_install = true,

      highlight = {
        enable = true,
        -- Better performance settings
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          local max_filesize = 250 * 1024 -- 250KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          -- Disable for problematic combinations
          if lang == "latex" and stats and stats.size > 50 * 1024 then
            return true
          end
          -- Check buffer line count for very long files
          local line_count = vim.api.nvim_buf_line_count(buf)
          if line_count > 10000 then
            return true
          end
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
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
      },
    })
  end,
}
