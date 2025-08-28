return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.indentscope").setup({
      symbol = "╎",
      draw = { animation = require("mini.indentscope").gen_animation.none() },
    })
    require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup({ mappings = { add = "gsa", delete = "gsd", replace = "gsr" } })
    require("mini.move").setup()
    require("mini.splitjoin").setup({ mappings = { toggle = "gS" } })
    require("mini.align").setup()
    require("mini.operators").setup({
      evaluate = { prefix = "g=" },
      exchange = { prefix = "gx" },
      multiply = { prefix = "gm" },
      replace = { prefix = "gr" },
      sort = { prefix = "gs" },
    })
    require("mini.sessions").setup({
      autoread = false,
      autowrite = true,
      directory = vim.fn.stdpath('data') .. '/sessions/',
      file = 'Session.vim',
    })
  end,
}
