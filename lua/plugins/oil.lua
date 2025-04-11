return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    float = {
      padding = 2,
      max_width = 100,
      max_height = 30,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
  config = function(_, opts)
    require("oil").setup(opts)

    -- Set the correct keymap here using Lua
    vim.keymap.set("n", "-", function()
      require("oil").open_float()
    end, { desc = "Open Oil File Manager (float)", silent = true })
  end,
}
