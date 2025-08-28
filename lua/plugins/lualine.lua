return {
  "nvim-lualine/lualine.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",

  opts = {
    options = {
      theme = "github_dark",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = { "filename" },
      lualine_x = {
        "diagnostics",
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if vim.tbl_isempty(clients) then return "" end
            local names = vim.tbl_map(function(client) return client.name end, clients)
            return "󰒍 " .. table.concat(names, ", ")
          end,
          cond = function() return not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 })) end
        },
        "encoding",
        "filetype"
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
