return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    -- Core features
    image = { enabled = true },
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
        patterns = { "GitSign", "MiniDiff", "Gitsign" },
      },
    },

    -- Disable picker (using fzf-lua)
    picker = { enabled = false },

    -- Performance features
    scope = { enabled = true },
    scratch = {
      enabled = true,
      ft = function()
        return vim.bo.filetype ~= "" and vim.bo.filetype or "markdown"
      end,
    },

    styles = {
      notification = {
        wo = { wrap = true },
        border = "rounded",
      },
    },
  },

  keys = {
    -- Core actions
    { "<leader>e",  function() Snacks.explorer() end,                desc = "Explorer" },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>z",  function() Snacks.zen() end,                     desc = "Zen mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Zoom mode" },
    { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete buffer" },
    { "<leader>un", function() Snacks.notifier.show_history() end,   desc = "Notification history" },
    { "<C-t>",      function() Snacks.terminal() end,                desc = "Terminal",            mode = { "n", "t" } },

    -- Scratch buffers
    { "<leader>s",  function() Snacks.scratch() end,                 desc = "Scratch buffer" },
    { "<leader>ss", function() Snacks.scratch.select() end,          desc = "Select scratch" },

    -- File operations
    { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename file" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git browse",          mode = { "n", "v" } },

    -- Word navigation
    { "]w",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next reference",      mode = { "n", "t" } },
    { "[w",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference",      mode = { "n", "t" } },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Global utilities
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd

        -- Essential toggles
        vim.keymap.set("n", "<leader>ud", function() Snacks.toggle.diagnostics() end, { desc = "Toggle diagnostics" })
        vim.keymap.set("n", "<leader>ul", function() Snacks.toggle.line_number() end, { desc = "Toggle line numbers" })
        vim.keymap.set("n", "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }) end,
          { desc = "Toggle wrap" })
        vim.keymap.set("n", "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }) end,
          { desc = "Toggle spelling" })
        vim.keymap.set("n", "<leader>uT", function() Snacks.toggle.treesitter() end, { desc = "Toggle treesitter" })
        vim.keymap.set("n", "<leader>ub",
          function() Snacks.toggle.option("background", { off = "light", on = "dark" }) end,
          { desc = "Toggle background" })
      end,
    })
  end,
}
