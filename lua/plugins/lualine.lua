-- Configure 'lualine.nvim' for a modern and highly customizable statusline.
-- It displays relevant information about the current Neovim session.

return {
    "nvim-lualine/lualine.nvim", -- Modern and customizable statusline.
    dependencies = {
      "nvim-tree/nvim-web-devicons",   -- File icons in the statusline.
      "projekt0n/github-nvim-theme", -- GitHub theme for consistent styling.
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "github_dark",             -- Use the GitHub dark theme.
          component_separators = { left = "", right = "" }, -- No separators between components.
          section_separators = { left = "", right = "" },   -- No separators between sections.
          globalstatus = true,               -- Display the statusline globally.
          disabled_filetypes = {           -- Disable the statusline for specific filetypes.
            statusline = { "dashboard", "alpha", "starter" }, -- Startup screens.
          },
        },
        sections = {
          lualine_a = { "mode" }, -- Display the current mode.
          lualine_b = {
            { "branch", icon = "" }, -- Show the current Git branch (icon hidden).
            {
              "diff", -- Show Git diff stats.
              symbols = {
                added = "+",    -- Symbol for added lines.
                modified = "~", -- Symbol for modified lines.
                removed = "-",  -- Symbol for removed lines.
              },
            },
          },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }, -- Filetype icon only.
            { "filename", path = 1 }, -- Show the relative path of the file.
            { "diagnostics" },         -- Show LSP/linter diagnostics.
          },
          lualine_x = {
            {
              -- Display active LSP clients.
              function()
                local clients = vim.lsp.get_active_clients()
                if not next(clients) then return "" end -- Return empty if no clients active.
  
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return "LSP: " .. table.concat(names, ", ") -- Concatenate client names.
              end,
            },
            "encoding",   -- Show file encoding.
            "fileformat", -- Show file format.
          },
          lualine_y = { "progress" }, -- Show file progress.
          lualine_z = { "location" }, -- Show current line/column.
        },
        extensions = { "lazy", "mason", "toggleterm" }, -- Integrate with Lazy, Mason, ToggleTerm.
      })
    end,
  }