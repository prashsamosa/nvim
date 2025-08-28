return {
  "stevearc/oil.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,

  keys = {
    { "-", function() require("oil").open_float() end, desc = "Open file manager" },
  },

  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = { show_hidden = true, natural_order = true },
    float = {
      padding = 2,
      max_width = 100,
      max_height = 30,
      border = "rounded",
    },
  },
}
