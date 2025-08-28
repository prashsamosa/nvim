return {
  -- Text objects and AI
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    config = true,
  },

  -- Surround operations
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
      },
    },
  },

  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    version = false,
    event = "VeryLazy",
    config = true,
  },

  -- Indent scope visualization
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "╎",
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    },
  },

  -- Move lines and selections
  {
    "echasnovski/mini.move",
    version = false,
    keys = {
      { "<A-h>", mode = { "n", "v" } },
      { "<A-j>", mode = { "n", "v" } },
      { "<A-k>", mode = { "n", "v" } },
      { "<A-l>", mode = { "n", "v" } },
    },
    config = true,
  },

  -- Split/join operations
  {
    "echasnovski/mini.splitjoin",
    version = false,
    keys = { "gS" },
    opts = {
      mappings = { toggle = "gS" },
    },
  },

  -- Alignment operations
  {
    "echasnovski/mini.align",
    version = false,
    keys = { { "ga", mode = { "n", "v" } } },
    config = true,
  },

  -- Various operators
  {
    "echasnovski/mini.operators",
    version = false,
    keys = {
      { "g=", desc = "Evaluate" },
      { "gx", desc = "Exchange" },
      { "gm", desc = "Multiply" },
      { "gr", desc = "Replace" },
      { "gs", desc = "Sort" },
    },
    opts = {
      evaluate = { prefix = "g=" },
      exchange = { prefix = "gx" },
      multiply = { prefix = "gm" },
      replace = { prefix = "gr" },
      sort = { prefix = "gs" },
    },
  },

  -- Sessions management
  {
    "echasnovski/mini.sessions",
    version = false,
    lazy = false,
    opts = {
      autoread = false,
      autowrite = true,
      directory = vim.fn.stdpath('data') .. '/sessions/',
      file = 'Session.vim',
    },
    keys = {
      { "<leader>Ss", function() require("mini.sessions").write() end,  desc = "Save session" },
      { "<leader>Sr", function() require("mini.sessions").read() end,   desc = "Read session" },
      { "<leader>Sd", function() require("mini.sessions").delete() end, desc = "Delete session" },
      { "<leader>Sl", function() require("mini.sessions").select() end, desc = "Select session" },
      {
        "<leader>Sc",
        function()
          require("mini.sessions").write(vim.fn.input("Session name: "))
        end,
        desc = "Save named session"
      },
      {
        "<leader>S.",
        function()
          require("mini.sessions").write(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
        end,
        desc = "Save directory session"
      },
    },
  },
}
