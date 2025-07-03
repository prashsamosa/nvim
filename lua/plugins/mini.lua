return {
  -- Core mini.nvim library
  { "echasnovski/mini.nvim", version = false },

  -- Icons for consistent iconography
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
    desc = "Icon provider",
  },

  -- File explorer
  -- {
  --   "echasnovski/mini.files",
  --   version = false,
  --   lazy = false,
  --   config = function()
  --     local MiniFiles = require("mini.files")

  --     MiniFiles.setup({
  --       content = {},
  --       mappings = {
  --         close = "q",
  --         go_in = "l",
  --         go_in_plus = "L",
  --         go_out = "h",
  --         go_out_plus = "H",
  --         mark_goto = "'",
  --         mark_set = "m",
  --         reset = "<BS>",
  --         reveal_cwd = "@",
  --         show_help = "g?",
  --         synchronize = "=",
  --         trim_left = "<",
  --         trim_right = ">",
  --       },
  --       options = {
  --         permanent_delete = false,
  --         use_as_default_explorer = true,
  --       },
  --       windows = {
  --         max_number = 4,
  --         preview = true,
  --         width_focus = 50,
  --         width_nofocus = 15,
  --         width_preview = 25,
  --       },
  --     })

  --     local github_colors = {
  --       bg = "#0d1117",
  --       bg_float = "#161b22",
  --       bg_sidebar = "#0d1117",
  --       fg = "#c9d1d9",
  --       border = "#30363d",
  --       keyword = "#ff7b72",
  --       constant = "#79c0ff",
  --       func = "#d2a8ff",
  --       string = "#a5d6ff",
  --       comment = "#8b949e",
  --       git_removed = "#f85149",
  --       warning = "#f0883e",
  --       success = "#56d364",
  --       selection = "#264f78",
  --     }

  --     local function setup_github_highlights()
  --       local hl = vim.api.nvim_set_hl
  --       hl(0, "MiniFilesBorder", { bg = "none", fg = github_colors.border })
  --       hl(0, "MiniFilesBorderModified", { bg = "none", fg = github_colors.warning })
  --       hl(0, "MiniFilesCursorLine", { bg = github_colors.selection })
  --       hl(0, "MiniFilesDirectory", { fg = github_colors.func, bold = true })
  --       hl(0, "MiniFilesFile", { fg = github_colors.fg })
  --       hl(0, "MiniFilesNormal", { bg = github_colors.bg_sidebar, fg = github_colors.fg })
  --       hl(0, "MiniFilesTitle", { fg = github_colors.constant, bold = true })
  --       hl(0, "MiniFilesTitleFocused", { fg = github_colors.keyword, bold = true })
  --       hl(0, "MiniFilesPreview", { bg = github_colors.bg_float, fg = github_colors.fg })
  --       hl(0, "MiniFilesModified", { fg = github_colors.warning, italic = true })
  --       hl(0, "MiniFilesHidden", { fg = github_colors.comment, italic = true })
  --     end

  --     vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_github_highlights })
  --     setup_github_highlights()

  --     local function minifiles_toggle(...)
  --       if not MiniFiles.close() then MiniFiles.open(...) end
  --     end

  --     vim.keymap.set("n", "<leader>me", function() minifiles_toggle() end, { desc = "Mini Files: Toggle explorer" })
  --     vim.keymap.set("n", "<leader>mE", function()
  --       minifiles_toggle(vim.api.nvim_buf_get_name(0))
  --     end, { desc = "Mini Files: Open at current file" })

  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "MiniFilesBufferCreate",
  --       callback = function(args)
  --         local buf_id = args.data.buf_id
  --         local show_dotfiles = true
  --         local filter_show = function(_) return true end
  --         local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end
  --         local toggle_dotfiles = function()
  --           show_dotfiles = not show_dotfiles
  --           MiniFiles.refresh({ content = { filter = show_dotfiles and filter_show or filter_hide } })
  --         end
  --         vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })

  --         local function map_split(lhs, direction, desc)
  --           vim.keymap.set("n", lhs, function()
  --             local cur = MiniFiles.get_explorer_state().target_window
  --             local win = vim.api.nvim_win_call(cur, function()
  --               vim.cmd(direction .. " split")
  --               return vim.api.nvim_get_current_win()
  --             end)
  --             MiniFiles.set_target_window(win)
  --           end, { buffer = buf_id, desc = desc })
  --         end

  --         map_split("<C-s>", "belowright horizontal", "Split horizontal")
  --         map_split("<C-v>", "belowright vertical", "Split vertical")
  --         map_split("<C-t>", "tab", "Open in new tab")

  --         local function map_util(lhs, fn, desc)
  --           vim.keymap.set("n", lhs, fn, { buffer = buf_id, desc = desc })
  --         end

  --         map_util("g~", function()
  --           local path = (MiniFiles.get_fs_entry() or {}).path
  --           if path then
  --             vim.fn.chdir(vim.fs.dirname(path))
  --             vim.notify("📁 CWD set to: " .. vim.fs.dirname(path), vim.log.levels.INFO)
  --           else
  --             vim.notify("Cursor is not on valid entry", vim.log.levels.WARN)
  --           end
  --         end, "Set cwd to current directory")

  --         map_util("gy", function()
  --           local path = (MiniFiles.get_fs_entry() or {}).path
  --           if path then
  --             vim.fn.setreg(vim.v.register, path)
  --             vim.notify("📋 Yanked: " .. path, vim.log.levels.INFO)
  --           else
  --             vim.notify("Cursor is not on valid entry", vim.log.levels.WARN)
  --           end
  --         end, "Yank path to clipboard")

  --         map_util("gx", function()
  --           local path = (MiniFiles.get_fs_entry() or {}).path
  --           if path then
  --             vim.ui.open(path)
  --             vim.notify("🚀 Opened with system default", vim.log.levels.INFO)
  --           else
  --             vim.notify("Cursor is not on valid entry", vim.log.levels.WARN)
  --           end
  --         end, "Open with system default")
  --       end,
  --     })

  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "MiniFilesWindowOpen",
  --       callback = function(args)
  --         local win_id = args.data.win_id
  --         vim.wo[win_id].winblend = 0
  --         local config = vim.api.nvim_win_get_config(win_id)
  --         config.border = "rounded"
  --         vim.api.nvim_win_set_config(win_id, config)
  --         vim.wo[win_id].winhighlight = "Normal:MiniFilesNormal,FloatBorder:MiniFilesBorder,CursorLine:MiniFilesCursorLine"
  --       end,
  --     })

  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "MiniFilesExplorerOpen",
  --       callback = function()
  --         MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "⚙️  Config directory" })
  --         MiniFiles.set_bookmark("d", vim.fn.stdpath("data"), { desc = "💾 Data directory" })
  --         MiniFiles.set_bookmark("h", vim.fn.expand("~"), { desc = "🏠 Home directory" })
  --         MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "💼 Working directory" })
  --         if vim.fn.isdirectory(".git") == 1 then
  --           MiniFiles.set_bookmark("r", ".", { desc = "📂 Project root" })
  --         end
  --       end,
  --     })

  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = {
  --         "MiniFilesActionCreate", "MiniFilesActionDelete", "MiniFilesActionRename",
  --         "MiniFilesActionCopy", "MiniFilesActionMove"
  --       },
  --       callback = function(event)
  --         local a, from, to = event.data.action, event.data.from, event.data.to
  --         local msg = ""
  --         local level = vim.log.levels.INFO
  --         if a == "create" then
  --           msg = "✨ Create: " .. vim.fn.fnamemodify(to, ":t")
  --         elseif a == "delete" then
  --           msg = "🗑️ Delete: " .. vim.fn.fnamemodify(from, ":t")
  --           level = vim.log.levels.WARN
  --         elseif a == "rename" then
  --           msg = "📝 Rename: " .. vim.fn.fnamemodify(from, ":t") .. " → " .. vim.fn.fnamemodify(to, ":t")
  --         elseif a == "copy" then
  --           msg = "📋 Copy: " .. vim.fn.fnamemodify(from, ":t") .. " → " .. vim.fn.fnamemodify(to, ":t")
  --         elseif a == "move" then
  --           msg = "📦 Move: " .. vim.fn.fnamemodify(from, ":t") .. " → " .. vim.fn.fnamemodify(to, ":t")
  --         end
  --         vim.notify(msg, level)
  --       end,
  --     })
  --   end,
  --   desc = "File explorer",
  -- },



  -- Smart commenting
  {
    "echasnovski/mini.comment",
    version = false,
    lazy = false,
    opts = {
      options = {
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
        textobject = "gc",
      },
    },
    desc = "Smart code commenting",
  },

  -- Text objects
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
    desc = "Enhanced text objects",
  },

  -- Surround manipulation
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
    desc = "Surround text objects manipulation",
  },

  -- Operators like replace, evaluate, etc.
  {
    "echasnovski/mini.operators",
    version = false,
    config = function()
      require("mini.operators").setup()
    end,
    desc = "Additional text operators",
  },

  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
    desc = "Auto-completion of bracket pairs",
  },

  -- Bracketed text navigation
  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      require("mini.bracketed").setup()
    end,
    desc = "Navigate through various text objects with brackets",
  },


  -- Fuzzy finder
  {
    "echasnovski/mini.pick",
    version = false,
    config = function()
      require("mini.pick").setup()

      vim.keymap.set("n", "<leader>mp", function()
        require("mini.pick").builtin.files()
      end, { desc = "Pick files" })

      vim.keymap.set("n", "<leader>mg", function()
        require("mini.pick").builtin.grep_live()
      end, { desc = "Grep live" })
    end,
    desc = "Fuzzy finder and picker",
  },

  -- Notifications
  {
    "echasnovski/mini.notify",
    version = false,
    event = "VeryLazy",
    config = function()
      local has_winblend = pcall(function()
        local win_id = vim.api.nvim_open_win(0, false, {
          relative = "editor", width = 1, height = 1, row = 0, col = 0, style = "minimal", winblend = 0
        })
        vim.api.nvim_win_close(win_id, true)
        return true
      end)

      local config = {
        window = {
          config = {
            border = "rounded",
            width = 60,
            winblend = has_winblend and 0 or nil,
          },
        },
        content = {
          default_timeout_ms = 5000,
        },
        lsp_progress = {
          enable = true,
          duration_ms = 500,
        },
      }

      require("mini.notify").setup(config)
      vim.notify = require("mini.notify").make_notify()
    end,
    desc = "Notification system",
  },

  -- Session management
  {
    "echasnovski/mini.sessions",
    version = false,
    lazy = false,
    config = function()
      require("mini.sessions").setup({
        autoread = true,
        autowrite = true,
        directory = vim.fn.stdpath("data") .. "/sessions",
        file = "Session.vim",
        verbose = { read = false, write = true, delete = true },
      })

      vim.keymap.set("n", "<leader>Ms", function()
        require("mini.sessions").write(nil)
      end, { desc = "Write session" })

      vim.keymap.set("n", "<leader>Mr", function()
        require("mini.sessions").read(nil)
      end, { desc = "Read last session" })

      vim.keymap.set("n", "<leader>Md", function()
        require("mini.sessions").delete(nil)
      end, { desc = "Delete session" })
    end,
    desc = "Session management",
  },

  -- Indentation guides
 {
  "echasnovski/mini.indentscope",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.indentscope").setup({
      draw = {
        delay = 100,
        animation = require("mini.indentscope").gen_animation.none(),
      },
      symbol = "╎",
      options = {
        try_as_border = true,
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "NvimTree", "neo-tree", "alpha", "snacks_dashboard" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

  end,
  desc = "Indentation scope visualization",
},
}
