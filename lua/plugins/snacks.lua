return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    -- Pre-initialization hook
    init = function()
      -- Set minimal UI characters
      vim.opt.fillchars:append({
        vert = " ",
        fold = " ",
        eob = " ",
        diff = " ",
        msgsep = " ",
      })

      -- Disable indent blankline color
      vim.cmd("highlight IndentBlanklineChar guifg=NONE")

      -- Global helper functions and toggle bindings
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd

          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", {
            off = 0,
            on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
            name = "Conceal",
          }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", {
            off = "light",
            on = "dark",
            name = "Dark Background",
          }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })

      -- File rename hook for Oil.nvim integration
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          local data = event.data and event.data.actions
          if data and data.type == "move" and data.src_url and data.dest_url then
            Snacks.rename.on_rename_file(data.src_url, data.dest_url)
          end
        end,
      })
    end,

    -- Plugin options
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
    ███████╗ █████╗ ███╗   ███╗ ██████╗ ███████╗ █████╗
    ██╔════╝██╔══██╗████╗ ████║██╔═══██╗██╔════╝██╔══██╗
    ███████╗███████║██╔████╔██║██║   ██║███████╗███████║
    ╚════██║██╔══██║██║╚██╔╝██║██║   ██║╚════██║██╔══██║
    ███████║██║  ██║██║ ╚═╝ ██║╚██████╔╝███████║██║  ██║
    ╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
          ]],
        },
      },
      input = { enabled = true },
      -- notifier = { enabled = true, timeout = 3000 },
      -- picker = { enabled = true }, -- Commented out since using fzf-lua
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = true },
      rename = { enabled = true },
      zen = {
        enabled = true,
        options = {
          window = {
            width = 0.85,
            options = {
              signcolumn = "no",
              number = false,
              relativenumber = false,
            },
          },
        },
      },
    },

    -- Key mappings
    keys = {
      -- Core buffer/command functionality (not overlapping with fzf-lua)
      { "<leader>,",       function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n",       function() Snacks.picker.notifications() end, desc = "Notification History" },

      -- File/search commands commented out since using fzf-lua
      -- { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      -- { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      -- { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },

      -- Git functionality commented out since using neogit
      -- { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      -- { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      -- { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      -- { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      -- { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
      -- { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

      -- Search commands commented out since using fzf-lua
      -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      -- { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
      -- { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep Project" },
      -- { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Search Word", mode = { "n", "x" } },

      -- Zen
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom Current Window" },

      -- Buffer management
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },

      -- Scratch
      { "<leader>.",  function() Snacks.scratch() end, desc = "Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch" },

      -- Notifications
      -- { "<leader>un", function() Snacks.notifier.hide() end, desc = "Hide Notifications" },

      -- File rename
      { "<leader>rf", function() Snacks.rename.rename_file() end, desc = "Rename File" },

      -- Word jumps - Changed to avoid conflict with Treesitter
      { "<leader>wn", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "<leader>wp", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    },

    -- Plugin setup
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
  }
