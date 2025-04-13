-- ~/.config/nvim/lua/plugins/markdown.lua
-- This file configures the 'render-markdown.nvim' plugin, which enhances
-- the display of Markdown files in Neovim by rendering various elements
-- with icons, borders, and improved formatting.

return {
  "MeanderingProgrammer/render-markdown.nvim", -- The plugin specification:
                                               -- name of the GitHub repository.
  ft = { "markdown" }, -- Lazy load this plugin only when a Markdown file
                       -- (`.md`) is opened. This improves startup time.
  dependencies = { -- List of other plugins that 'render-markdown.nvim' depends on.
      "nvim-treesitter/nvim-treesitter", -- Required for parsing Markdown syntax
                                       -- to accurately render elements.
      "echasnovski/mini.nvim",         -- Optional dependency for icons. If you
                                       -- prefer, you can use 'mini.icons' from
                                       -- this suite.
      -- Alternative icon plugin:
      -- "nvim-tree/nvim-web-devicons"
  },
  opts = { -- Configuration options for 'render-markdown.nvim'.
      completions = { -- Configuration for Markdown-specific completions.
          blink = { -- Integration with the 'blink.cmp' completion plugin.
              enabled = true, -- Enable Markdown-aware completions when using blink.cmp.
          },
      },

      -- Optional fine-tuning of the appearance of rendered Markdown elements.
      appearance = {
          heading = { -- Style for Markdown headings (h1, h2, etc.).
              icon = "󰉫", -- Icon to display before headings (uses a Nerd Font icon).
                           -- You could also use "" for a different style.
              border = "solid", -- Type of border around headings. Options:
                              -- "none", "single", "double", "rounded", "solid", etc.
              padding = 1,    -- Padding (in characters) around the heading text.
              width = "full", -- Make the heading span the full width of the window.
              color = "Title", -- Highlight group to use for the heading text.
          },
          bullet = { -- Style for bullet points in unordered lists.
              icon = "•",      -- The bullet point character.
              color = "Comment", -- Highlight group for the bullet.
              padding = 1,     -- Padding after the bullet.
          },
          checkbox = { -- Style for checkboxes in task lists.
              icons = { -- Icons for different checkbox states.
                  [" "] = "󰄱", -- Unchecked (Nerd Font icon).
                  ["x"] = "󰄵", -- Checked (Nerd Font icon).
                  ["-"] = "󰜺", -- Indeterminate (Nerd Font icon).
              },
              color = "Boolean", -- Highlight group for the checkbox icons.
          },
          code_block = { -- Style for fenced code blocks.
              border = "rounded", -- Border around the code block.
              padding = 1,       -- Padding inside the code block.
              width = "full",    -- Make the code block span the full width.
              background = "Visual", -- Highlight group for the code block background.
          },
          callout = { -- Style for callout blocks (e.g., > note).
              icon = "",       -- Icon to display (Obsidian/GitHub style).
              border = "none",    -- No border around callouts.
              line_padding = 1, -- Padding for each line within the callout.
              color = "String",   -- Highlight group for the callout text.
          },
          table = { -- Style for Markdown tables.
              border = "solid", -- Border around the table.
              color = "Type",   -- Highlight group for table elements.
              align = true,   -- Align table columns.
          },
          link = { -- Style for Markdown links.
              icon = "",         -- Icon to display before links.
              color = "Identifier", -- Highlight group for the link text.
          },
          latex_block = { -- Style for LaTeX blocks (using $$ ... $$).
              enabled = true,  -- Enable rendering of LaTeX blocks.
              color = "Special", -- Highlight group for LaTeX.
          },
      },

      -- Performance optimization for rendering large Markdown files.
      performance = {
          max_lines = 5000, -- Disable rendering enhancements for files with
                            -- more than 5000 lines to prevent performance issues.
                            -- Set to `false` or a very high number to disable
                            -- this limit.
      },
  },
  config = function(_, opts) -- Configuration function that is called when
                             -- the plugin is loaded. The first argument `_` is
                             -- unused, and `opts` contains the configuration
                             -- defined above.
      require("render-markdown").setup(opts) -- Calls the setup function of the
                                           -- 'render-markdown' plugin with the
                                           -- provided options.

      -- Helpful keybindings for interacting with the rendered Markdown view.
      local map = vim.keymap.set -- Alias for `vim.keymap.set` for brevity.
      local function nmap(lhs, rhs, desc) -- Helper function to define normal mode
                                         -- key mappings with common options.
          map("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
      end

      -- Changed prefix from <leader>u to <leader>m to avoid conflicts
      nmap("<leader>mm", "<cmd>RenderMarkdown toggle<CR>", "[M]arkdown Toggle Render")
      -- Changed <leader>me to <leader>mE to avoid conflict with mini.files
      nmap("<leader>mE", "<cmd>RenderMarkdown expand<CR>", "[M]arkdown Expand View")
      nmap("<leader>mc", "<cmd>RenderMarkdown contract<CR>", "[M]arkdown Contract View")
      nmap("<leader>ml", "<cmd>RenderMarkdown log<CR>", "[M]arkdown Open Log")
      nmap("<leader>md", "<cmd>RenderMarkdown debug<CR>", "[M]arkdown Debug Line")
      nmap("<leader>ms", "<cmd>RenderMarkdown config<CR>", "[M]arkdown Show Config")
  end,
}