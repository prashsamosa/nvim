return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
  },
  opts = {
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = false,
    hijack_netrw = true,

    sort = {
      sorter = "name",
      folders_first = true,
    },

    view = {
      width = 34,
      side = "left",
      signcolumn = "yes",
      preserve_window_proportions = true,
    },

    renderer = {
      root_folder_label = ":~",
      highlight_git = true,
      highlight_opened_files = "name",
      indent_markers = { enable = true },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },

    filters = {
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      custom = { ".DS_Store", "thumbs.db" },
    },

    git = {
      enable = true,
      ignore = true,
    },

    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },

    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
    },

    live_filter = {
      prefix = "🔍 ",
      always_show_folders = false,
    },

    log = {
      enable = false,
    },
  },

  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- Appearance overrides (transparent bg, visible split)
    local hl = vim.api.nvim_set_hl
    hl(0, "NvimTreeNormal", { bg = "none" })
    hl(0, "NvimTreeNormalNC", { bg = "none" })
    hl(0, "NvimTreeVertSplit", { fg = "#30363d", bg = "none" })
    hl(0, "WinSeparator", { fg = "#30363d", bg = "none" })

    -- Folder name highlights
    hl(0, "NvimTreeFolderName", { fg = "#79c0ff", bold = true })
    hl(0, "NvimTreeOpenedFolderName", { fg = "#d2a8ff", bold = true })
    hl(0, "NvimTreeRootFolder", { fg = "#ff7b72", bold = true })
    hl(0, "NvimTreeCursorLine", { bg = "#1a1b26" })

    -- Pipe as vertical separator
    vim.opt.fillchars:append("vert:│")
  end,
}
