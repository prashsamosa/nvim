return {
    "nvim-neo-tree/neo-tree.nvim", -- File explorer plugin.
    branch = "v3.x", -- Use the v3.x branch for stability and latest features.
    dependencies = {
        "nvim-lua/plenary.nvim", -- Lua utility library.
        "nvim-tree/nvim-web-devicons", -- Optional: File icons.
        "MunifTanjim/nui.nvim", -- UI library used by neo-tree.
        -- {"3rd/image.nvim", opts = {}}, -- Optional: Image preview (see docs).
    },
    lazy = false, -- Load immediately on startup for instant access.
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        sources = { "filesystem", "buffers", "git_status" }, -- Display file system, open buffers, and Git status.
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        -- Prevent neo-tree from replacing these buffer types when opening files.
        filesystem = {
            bind_to_cwd = false, -- Don't automatically change root to current working directory.
            follow_current_file = { enabled = true }, -- Automatically show and focus the current file in neo-tree.
            use_libuv_file_watcher = true, -- Use Neovim's built-in file watcher for better performance.
        },
        window = {
            mappings = {
                ["l"] = "open", -- Open file or directory.
                ["h"] = "close_node", -- Close focused directory.
                ["<space>"] = "none", -- Disable default space action.
                ["Y"] = { -- Copy the path of the selected node to the clipboard.
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c") -- Copy to system clipboard.
                    end,
                    desc = "Copy Path to Clipboard",
                },
                ["O"] = { -- Open the selected file or directory with the system's default application.
                    function(state)
                        require("lazy.util").open(state.tree:get_node().path, { system = true })
                    end,
                    desc = "Open with System Application",
                },
                ["P"] = { "toggle_preview", config = { use_float = false } },
                -- Toggle preview window (in a side split).
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- Show expander icons for nested files/directories.
                expander_collapsed = "", -- Icon for collapsed directories.
                expander_expanded = "",  -- Icon for expanded directories.
                expander_highlight = "NeoTreeExpander", -- Highlight group for expander icons.
            },
            git_status = {
                symbols = {
                    unstaged = "󰄱", -- Symbol for unstaged changes.
                    staged = "󰱒",  -- Symbol for staged changes.
                },
            },
        },
    },
}