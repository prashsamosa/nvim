-- Configure 'render-markdown.nvim' for enhanced Markdown display in Neovim.
-- Renders Markdown elements with icons, borders, and improved formatting.

return {
    "MeanderingProgrammer/render-markdown.nvim", -- Plugin specification.
    ft = { "markdown" }, -- Load only for Markdown files (.md).
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- Required for Markdown syntax parsing.
        "echasnovski/mini.nvim",         -- Optional: For icons (can also use mini.icons).
        -- Alternative icon plugin: "nvim-tree/nvim-web-devicons"
    },
    opts = { -- Configuration options.
        completions = { -- Markdown-specific completions.
            blink = { enabled = true }, -- Enable for blink.cmp.
        },

        appearance = { -- Style of rendered Markdown elements.
            heading = { -- Headings (h1, h2, etc.).
                icon = "󰉫",       -- Icon before heading.
                border = "solid",   -- Border style.
                padding = 1,        -- Padding around text.
                width = "full",     -- Full width.
                color = "Title",    -- Highlight group.
            },
            bullet = { -- Unordered list bullets.
                icon = "•",        -- Bullet character.
                color = "Comment",   -- Highlight group.
                padding = 1,        -- Padding after bullet.
            },
            checkbox = { -- Task list checkboxes.
                icons = {
                    [" "] = "󰄱", -- Unchecked.
                    ["x"] = "󰄵", -- Checked.
                    ["-"] = "󰜺", -- Indeterminate.
                },
                color = "Boolean", -- Highlight group.
            },
            code_block = { -- Fenced code blocks.
                border = "rounded", -- Border style.
                padding = 1,        -- Padding inside.
                width = "full",     -- Full width.
                background = "Visual", -- Background highlight.
            },
            callout = { -- Callout blocks (> note).
                icon = "",         -- Icon.
                border = "none",    -- No border.
                line_padding = 1, -- Padding per line.
                color = "String",   -- Highlight group.
            },
            table = { -- Markdown tables.
                border = "solid", -- Border style.
                color = "Type",    -- Highlight group.
                align = true,      -- Align columns.
            },
            link = { -- Markdown links.
                icon = "",         -- Icon before link.
                color = "Identifier", -- Highlight group.
            },
            latex_block = { -- LaTeX blocks ($$ ... $$).
                enabled = true,   -- Enable rendering.
                color = "Special",  -- Highlight group.
            },
        },

        performance = {
            max_lines = 5000, -- Disable rendering for very long files.
            -- Set to `false` or high number to disable limit.
        },
    },
    config = function(_, opts)
        require("render-markdown").setup(opts)

        -- Keybindings (prefix changed to <leader>m to avoid conflicts).
        local map = vim.keymap.set
        local function nmap(lhs, rhs, desc)
            map("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
        end

        nmap("<leader>mm", "<cmd>RenderMarkdown toggle<CR>", "[M]arkdown Toggle Render")
        nmap("<leader>mE", "<cmd>RenderMarkdown expand<CR>", "[M]arkdown Expand View")
        nmap("<leader>mc", "<cmd>RenderMarkdown contract<CR>", "[M]arkdown Contract View")
        nmap("<leader>ml", "<cmd>RenderMarkdown log<CR>", "[M]arkdown Open Log")
        nmap("<leader>md", "<cmd>RenderMarkdown debug<CR>", "[M]arkdown Debug Line")
        nmap("<leader>ms", "<cmd>RenderMarkdown config<CR>", "[M]arkdown Show Config")
    end,
}