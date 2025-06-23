return {
  "nvim-lualine/lualine.nvim",
  desc = "Statusline plugin with theme and LSP info",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function lsp_client_names()
      local ok, clients = pcall(vim.lsp.get_clients, { bufnr = 0 })
      if not ok or not clients or vim.tbl_isempty(clients) then return "" end

      local names, seen = {}, {}
      for _, client in ipairs(clients) do
        if client.name and not seen[client.name] then
          table.insert(names, client.name)
          seen[client.name] = true
        end
      end
      return #names > 0 and "󰒍 LSP: " .. table.concat(names, ", ") or ""
    end

    require("lualine").setup({
      options = {
        theme = "github_dark",
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
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, shorting_target = 40 },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn  = " ",
              info  = " ",
              hint  = " ",
            },
          },
          {
            lsp_client_names,
            cond = function() return not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0 })) end,
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
        lualine_c = {
          { "filename", path = 1, shorting_target = 40 },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "lazy",
        "mason",
        "toggleterm",
        "nvim-tree",
      },
    })
  end,
}
