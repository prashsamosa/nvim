-- plugins/oil.lua
return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    float = { padding = 2, border = "rounded" },
  },
  keys = {
    { "-", "<cmd>Oil --float<CR>", desc = "Open parent directory in Oil" },
  },
}
