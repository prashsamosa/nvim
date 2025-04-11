return {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          -- Stylish ASCII header
          { section = "header" },
  
          -- Terminal pane with colorscript art
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 6,
            padding = 1,
          },
  
          -- Keymaps list with gap and padding
          {
            section = "keys",
            gap = 1,
            padding = 1,
          },
  
          -- Recent files (right pane)
          {
            pane = 2,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
  
          -- Project list (right pane)
          {
            pane = 2,
            icon = " ",
            title = "Projects",
            section = "projects",
            indent = 2,
            padding = 1,
          },
  
          -- Git status terminal (right pane, conditional)
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
  
          -- Show startup time (always last)
          { section = "startup" },
        },
  
        -- Optional: center dashboard
        width = 70,
        row = nil,
        col = nil,
  
        -- Highlight customization (optional)
        formats = {
          key = function(item)
            return {
              { "[", hl = "SpecialComment" },
              { item.key, hl = "Keyword" },
              { "]", hl = "SpecialComment" },
            }
          end,
        },
      },
    },
  }
  