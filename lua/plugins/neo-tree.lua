return {
  "nvim-neo-tree/neo-tree.nvim", -- The plugin specification: name of the GitHub repository.
  branch = "v3.x", -- Specifies the branch of the repository to use.
  dependencies = { -- List of other plugins that neo-tree.nvim depends on.
      "nvim-lua/plenary.nvim", -- A Lua utility library for Neovim.
      "nvim-tree/nvim-web-devicons", -- Optional: Adds file icons to neo-tree.
      "MunifTanjim/nui.nvim", -- A UI library for Neovim, used by neo-tree.
      -- {"3rd/image.nvim", opts = {}}, -- Optional: For image preview in neo-tree.
                                       -- See `# Preview Mode` in neo-tree documentation.
  },
  lazy = false, -- Load neo-tree immediately on startup.
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = { -- Configuration options for neo-tree.nvim.
      sources = { "filesystem", "buffers", "git_status" }, -- Enable these sources in neo-tree.
                                                         -- "filesystem": Displays the file system.
                                                         -- "buffers": Displays open buffers.
                                                         -- "git_status": Displays Git status.
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      -- When opening a file from neo-tree, do not replace buffers of these types.
      filesystem = { -- Configuration for the "filesystem" source.
          bind_to_cwd = false, -- Do not automatically change neo-tree's root
                             -- directory to the current working directory.
          follow_current_file = { enabled = true }, -- Automatically reveal and focus
                                                   -- the current file in neo-tree.
          use_libuv_file_watcher = true, -- Use Neovim's built-in file watcher
                                        -- for better performance and reliability.
      },
      window = { -- Configuration for the neo-tree window.
          mappings = { -- Custom key mappings within the neo-tree window.
              ["l"] = "open", -- Pressing 'l' opens the selected file or directory.
              ["h"] = "close_node", -- Pressing 'h' closes the currently focused directory.
              ["<space>"] = "none", -- Disable the default action for space.
              ["Y"] = { -- Pressing 'Y' performs the following function.
                  function(state) -- 'state' contains information about the current neo-tree state.
                      local node = state.tree:get_node() -- Get the currently selected node.
                      local path = node:get_id() -- Get the path (ID) of the node.
                      vim.fn.setreg("+", path, "c") -- Copy the path to the system clipboard ("+").
                  end,
                  desc = "Copy Path to Clipboard", -- Description for the key mapping.
              },
              ["O"] = { -- Pressing 'O' performs the following function.
                  function(state)
                      require("lazy.util").open(state.tree:get_node().path, { system = true })
                      -- Open the selected file or directory with the system's default application.
                  end,
                  desc = "Open with System Application",
              },
              ["P"] = { "toggle_preview", config = { use_float = false } },
              -- Pressing 'P' toggles the preview window. 'use_float = false'
              -- means the preview will be in a side split, not a floating window.
          },
      },
      default_component_configs = { -- Default configuration for various components
                                     -- displayed in neo-tree (e.g., indent, git status).
          indent = {
              with_expanders = true, -- Show expander icons if file nesting is enabled.
              expander_collapsed = "", -- Icon for collapsed directories (can be a Nerd Font icon).
              expander_expanded = "",  -- Icon for expanded directories.
              expander_highlight = "NeoTreeExpander", -- Highlight group for expander icons.
          },
          git_status = {
              symbols = { -- Custom symbols for Git status.
                  unstaged = "󰄱", -- Symbol for unstaged changes (Nerd Font icon).
                  staged = "󰱒",   -- Symbol for staged changes (Nerd Font icon).
              },
          },
      },
  },
}