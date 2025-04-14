return {
  "nvim-lualine/lualine.nvim", -- Modern and extensible statusline plugin for Neovim.
  dependencies = {
      "nvim-tree/nvim-web-devicons", -- Adds fancy icons to the statusline.
      "projekt0n/github-nvim-theme", -- Provides the GitHub theme for consistent UI.
  },
  config = function()
      require("lualine").setup({
          options = {
              theme = "github_dark", -- Use the dark version of the GitHub theme.
              component_separators = { left = "", right = "" }, -- Remove default separators between components.
              section_separators = { left = "", right = "" }, -- Remove default separators between sections.
              globalstatus = true, -- Display the statusline even when no buffer is open.
              disabled_filetypes = { -- Disable the statusline for these filetypes.
                  statusline = { "dashboard", "alpha", "starter" }, -- Common startup screens.
              },
          },
          sections = {
              lualine_a = { "mode" }, -- Display the current editor mode (Normal, Insert, Visual, etc.).
              lualine_b = {
                  { "branch", icon = "" }, -- Display the Git branch name (hide the default icon).
                  {
                      "diff", -- Display Git diff information (added, modified, removed lines).
                      symbols = {
                          added = " ", -- Hide the icon for added lines.
                          modified = " ", -- Hide the icon for modified lines.
                          removed = " " -- Hide the icon for removed lines.
                      },
                  },
              },
              lualine_c = {
                  { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }, -- Display filetype icon only.
                  { "filename", path = 1 }, -- Display the relative path of the current file.
                  { "diagnostics" }, -- Display any warnings, errors, etc.
              },
              lualine_x = {
                  {
                      -- Display LSP (Language Server Protocol) status: names of active servers.
                      function()
                          local clients = vim.lsp.get_active_clients()
                          if next(clients) == nil then return "" end

                          local names = {}
                          for _, client in ipairs(clients) do
                              table.insert(names, client.name)
                          end
                          return "LSP: " .. table.concat(names, ", ") -- Concatenate the names with commas.
                      end,
                  },
                  "encoding", -- Display the current file encoding.
                  "fileformat", -- Display the current file format (e.g., unix, dos).
              },
              lualine_y = { "progress" }, -- Display the current position in the file as a percentage.
              lualine_z = { "location" }, -- Display the current line and column number.
          },
          extensions = { "lazy", "mason", "toggleterm" }, -- Neo-tree removed
      })
  end
}