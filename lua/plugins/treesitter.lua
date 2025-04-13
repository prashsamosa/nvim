return {
  "nvim-treesitter/nvim-treesitter", -- The plugin specification: name of the GitHub repository.
  build = ":TSUpdate", -- Command to run after the plugin is installed or updated to download
                      -- the language parsers.
  config = function()
      local configs = require("nvim-treesitter.configs") -- Load the treesitter configuration module.

      configs.setup({ -- Call the setup function with the following configuration.
          ensure_installed = { -- List of language parsers to ensure are installed.
              "c", "lua", "vim", "vimdoc", "query",
              "elixir", "heex", "javascript", "html",
              "markdown", "markdown_inline", -- Required for proper Markdown parsing.
              "latex",                     -- Optional: for LaTeX block concealing and highlighting.
          },
          auto_install = true, -- Automatically install language parsers if they are not present.
          sync_install = false, -- Do not block Neovim during parser installation. Install in the background.

          highlight = { enable = true }, -- Enable syntax highlighting based on the treesitter parser.
          indent = { enable = true },    -- Enable automatic code indentation based on the treesitter parser.

          incremental_selection = { -- Enable incremental selection based on the syntax tree.
              enable = true,
              keymaps = { -- Key mappings for incremental selection.
                  init_selection = "<Enter>", -- Start the selection with Enter.
                  node_incremental = "<Enter>", -- Expand the selection to the parent node with Enter.
                  scope_incremental = false,  -- Disable scope-based incremental selection.
                  node_decremental = "<Backspace>", -- Shrink the selection to the previous node with Backspace.
              },
          },
      })
  end
}