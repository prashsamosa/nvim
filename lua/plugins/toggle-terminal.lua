-- Configure 'toggleterm.nvim' for a toggleable terminal in Neovim.

return {
  "akinsho/toggleterm.nvim",
  version = "*", -- Use the latest version.
  keys = {
    { "<C-\\>", desc = "Toggle Terminal" },
    { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (horizontal)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal (vertical)" },
    { "<leader>tl", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Send line to terminal" },
    { "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select terminal" },
  },
  opts = {
    open_mapping = [[<C-\>]], -- Key to open terminal.
    direction = "float",       -- Default terminal direction.
    float_opts = {
      border = "curved", -- Curved borders.
      winblend = 0,    -- Opaque window.
    },
    size = function(term)
      if term.direction == "horizontal" then
        return 15 -- Height for horizontal.
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4 -- Width for vertical (40%).
      end
    end,
  },
}
