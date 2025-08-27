return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    -- Core features (simplified - many are enabled by default)
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    terminal = { enabled = true },
    scroll = { enabled = true },
    notifier = { enabled = true },
    bufdelete = { enabled = true },
    zen = { enabled = true },
    words = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    gitbrowse = { enabled = true },

    -- Status column - improved configuration
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = true,
        git_hl = true,
      },
      git = {
        -- Updated pattern for better git integration
        patterns = { "GitSign", "MiniDiff", "Gitsign" },
      },
    },

    -- Disable picker (you're using fzf-lua - good choice!)
    picker = { enabled = false },

    -- Performance features
    scope = { enabled = true },
    scratch = {
      enabled = true,
      ft = function()
        -- Auto-detect filetype based on buffer name
        return vim.bo.filetype ~= "" and vim.bo.filetype or "markdown"
      end,
    },

    -- Remove toggle and profiler from opts - they're always available
    -- Remove dim - it can cause performance issues
  },

  keys = {
    -- Core actions (streamlined)
    { "<leader>e",  function() Snacks.explorer() end,                desc = "Explorer" },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>z",  function() Snacks.zen() end,                     desc = "Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Zoom Mode" },
    { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
    { "<leader>un", function() Snacks.notifier.show_history() end,   desc = "Notifications" },
    { "<C-t>",      function() Snacks.terminal() end,                desc = "Terminal",       mode = { "n", "t" } },

    -- Scratch buffers (fixed key conflicts with mini.sessions)
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch" },

    -- File operations
    { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",     mode = { "n", "v" } },

    -- Word navigation (improved)
    { "]w",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference", mode = { "n", "t" } },
    { "[w",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Global utilities
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd

        -- Essential toggles only
        vim.keymap.set("n", "<leader>ud", function() Snacks.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
        vim.keymap.set("n", "<leader>ul", function() Snacks.toggle.line_number() end, { desc = "Toggle Line Numbers" })
        vim.keymap.set("n", "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }) end,
          { desc = "Toggle Wrap" })
        vim.keymap.set("n", "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }) end,
          { desc = "Toggle Spell" })
        vim.keymap.set("n", "<leader>ih", function() Snacks.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
        vim.keymap.set("n", "<leader>uT", function() Snacks.toggle.treesitter() end, { desc = "Toggle Treesitter" })
        vim.keymap.set("n", "<leader>ub",
          function() Snacks.toggle.option("background", { off = "light", on = "dark" }) end,
          { desc = "Toggle Background" })
      end,
    })
  end,
}
