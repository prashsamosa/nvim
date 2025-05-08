-- Configure 'lualine.nvim' for a modern and highly customizable statusline.
-- It displays relevant information about the current Neovim session.

return {
  "nvim-lualine/lualine.nvim",     -- Modern and customizable statusline.
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons in the statusline. Requires Nerd Font.
    -- NOTE: The theme "projekt0n/github-nvim-theme" might need installation.
    -- If you don't have it, change the theme option below or install the theme plugin.
    -- Example: "projekt0n/github-nvim-theme", -- GitHub theme for consistent styling.
  },
  config = function()
    require("lualine").setup({
      options = {
        -- If you haven't installed "projekt0n/github-nvim-theme", use a built-in theme
        -- or one provided by another plugin you have (e.g., 'tokyonight', 'catppuccin', 'onedark').
        -- theme = "auto", -- Or 'tokyonight', 'catppuccin', etc.
        theme = "github_dark",                                          -- Use the GitHub dark theme (ensure theme plugin is installed).
        component_separators = { left = "", right = "" },               -- No separators between components.
        section_separators = { left = "", right = "" },                 -- No separators between sections.
        globalstatus = true,                                            -- Display the statusline globally.
        disabled_filetypes = {                                          -- Disable the statusline for specific filetypes.
          statusline = { "dashboard", "alpha", "starter", "NvimTree" }, -- Added NvimTree.
          winbar = {},
        },
        always_divide_middle = true, -- Ensures middle section components are always distinct.
      },
      sections = {
        lualine_a = { "mode" }, -- Display the current mode.
        lualine_b = {
          { "branch", icon = "" }, -- Show the current Git branch with an icon (optional: remove icon = '').
          {
            "diff", -- Show Git diff stats.
            symbols = {
              added = " ", -- Symbol for added lines (using Nerd Font icons).
              modified = " ", -- Symbol for modified lines.
              removed = " ", -- Symbol for removed lines.
            },
            source = nil, -- Use default diff source.
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "",      padding = { left = 1, right = 0 } }, -- Filetype icon only.
          { "filename", path = 1,         shorting_target = 40 },                                   -- Show relative path (1 level), shorten if long.
        },
        lualine_x = {
          {
            "diagnostics", -- Show LSP/linter diagnostics.
            symbols = { error = " ", warn = " ", info = " ", hint = " " }
          },
          {
            -- Display active LSP clients for the current buffer (Corrected Function).
            function()
              -- Use vim.lsp.get_clients({ bufnr = 0 }) instead of deprecated get_active_clients().
              local clients = vim.lsp.get_clients({ bufnr = 0 }) -- Get clients attached to the *current* buffer.

              if not next(clients) then
                return "" -- Return empty if no clients active for this buffer.
              end

              local names = {}
              local added_names = {} -- Keep track of names to avoid duplicates.
              for _, client in ipairs(clients) do
                -- Check if client has a name and if it hasn't been added already.
                if client.name and not added_names[client.name] then
                  table.insert(names, client.name)
                  added_names[client.name] = true
                end
              end

              if not next(names) then
                return "" -- Return empty if no clients with names found.
              end

              -- Optional: Add an icon before the list (requires Nerd Font).
              return "󰒍 LSP: " .. table.concat(names, ", ") -- Concatenate unique client names.
            end,
            icon = nil, -- Icon is handled within the function string now.
          },
          "encoding", -- Show file encoding.
          "fileformat", -- Show file format.
        },
        lualine_y = { "progress" }, -- Show file progress (percentage).
        lualine_z = { "location" }, -- Show current line/column.
      },
      inactive_sections = { -- How sections look in non-active windows.
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1, shorting_target = 40 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},                                                -- Empty tabline definition (can be configured separately if needed).
      winbar = {},                                                 -- Empty winbar definition.
      inactive_winbar = {},                                        -- Empty inactive_winbar definition.
      extensions = { "lazy", "mason", "toggleterm", "nvim-tree" }, -- Integrate with common plugins.
    })
  end,
}
