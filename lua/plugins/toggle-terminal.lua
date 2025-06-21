return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", desc = "Toggle Terminal" },
    { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (Float)" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (Horizontal)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal (Vertical)" },
    { "<leader>tl", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send Line to Terminal" },
    { "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select Terminal" },
  },
  opts = {
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = {
      border = "curved",
      winblend = 0,
    },
    -- Terminal size based on direction
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  },
}
