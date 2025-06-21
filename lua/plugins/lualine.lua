return {
  "nvim-lualine/lualine.nvim",
  desc = "Statusline plugin with theme and LSP info",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For file icons
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "github_dark", -- Theme name (requires lualine theme or custom colorscheme)
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter", "NvimTree" },
          winbar = {},
        },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
        },
        lualine_c = {
          -- Show only icon
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- Full file path (shortened to target 40 chars)
          { "filename", path = 1, shorting_target = 40 },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          {
            -- Show active LSP client(s)
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if vim.tbl_isempty(clients) then return "" end

              local names, seen = {}, {}
              for _, client in ipairs(clients) do
                if client.name and not seen[client.name] then
                  table.insert(names, client.name)
                  seen[client.name] = true
                end
              end

              return #names > 0 and "󰒍 LSP: " .. table.concat(names, ", ") or ""
            end,
          },
          "encoding",
          "fileformat",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1, shorting_target = 40 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "lazy",       -- Plugin manager
        "mason",      -- LSP/DAP/linter manager
        "toggleterm", -- Terminal integration
        "nvim-tree",  -- File explorer
      },
    })
  end,
}
