-- Configure 'neo-tree.nvim' for a modern and highly customizable file explorer.

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- Use the v3.x branch for stability and latest features.
    dependencies = {
        "nvim-lua/plenary.nvim",         -- Required: Lua utility library.
        "nvim-tree/nvim-web-devicons",  -- Optional: File icons.
        "MunifTanjim/nui.nvim",          -- Required: UI library for neo-tree.
        -- Uncomment below for image previews (optional).
        -- { "3rd/image.nvim", opts = {} },
    },
    lazy = false, -- Load neo-tree immediately on startup.
    opts = {
        sources = { "filesystem", "buffers", "git_status" }, -- Enable filesystem, buffers, and Git status views.
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" }, -- Preserve these buffer types.
        filesystem = {
            bind_to_cwd = false, -- Do not auto-bind neo-tree's root to the current working directory.
            follow_current_file = { enabled = true }, -- Highlight the active file in neo-tree.
            use_libuv_file_watcher = true, -- Use libuv for efficient file system updates.
        },
        window = {
            mappings = {
                ["l"] = "open",       -- Open file or expand/collapse directory.
                ["h"] = "close_node", -- Collapse the current directory.
                ["<space>"] = "none", -- Disable the default space key action.
                ["Y"] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c") -- Copy the file path to the clipboard.
                    end,
                    desc = "Copy Path to Clipboard",
                },
                ["O"] = {
                    function(state)
                        require("lazy.util").open(state.tree:get_node().path, { system = true })
                    end,
                    desc = "Open with System Application",
                },
                ["P"] = { "toggle_preview", config = { use_float = false } }, -- Toggle preview in a split window.
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- Show expand/collapse icons for directories.
                expander_collapsed = "", -- Icon for collapsed directories.
                expander_expanded = "",  -- Icon for expanded directories.
                expander_highlight = "NeoTreeExpander", -- Highlight group for expander icons.
            },
            git_status = {
                symbols = {
                    unstaged = "󰄱", -- Symbol for unstaged changes.
                    staged = "󰱒",   -- Symbol for staged changes.
                },
            },
        },
    },
}