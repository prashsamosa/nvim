-- Configure 'render-markdown.nvim' for enhanced Markdown display in Neovim.

return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" }, -- Load only for Markdown files.
    dependencies = {
        "nvim-treesitter/nvim-treesitter", -- Required for Markdown syntax parsing.
        "echasnovski/mini.nvim",           -- Optional: Provides icons (can use other icon plugins).
        -- Alternative: Uncomment below to use nvim-web-devicons for icons.
        -- "nvim-tree/nvim-web-devicons",
    },
    opts = {
        completions = {
            blink = { enabled = true }, -- Enable blink.cmp completions for Markdown.
        },
        appearance = {
            heading = {
                icon = "󰉫",       -- Icon for headings (requires Nerd Font).
                border = "solid",    -- Border style: "none", "solid", "dashed", etc.
                padding = 1,         -- Padding around heading text.
                width = "full",      -- Full-width heading.
                color = "Title",     -- Highlight group for heading text.
            },
            bullet = {
                icon = "•",          -- Bullet point character.
                color = "Comment",   -- Highlight group for bullets.
                padding = 1,         -- Padding after the bullet.
            },
            checkbox = {
                icons = {
                    [" "] = "󰄱", -- Unchecked checkbox.
                    ["x"] = "󰄵", -- Checked checkbox.
                    ["-"] = "󰜺", -- Indeterminate checkbox.
                },
                color = "Boolean", -- Highlight group for checkboxes.
            },
            code_block = {
                border = "rounded",  -- Border style for code blocks.
                padding = 1,         -- Padding inside code blocks.
                width = "full",      -- Full-width code blocks.
                background = "Visual", -- Highlight group for code block background.
            },
            callout = {
                icon = "",         -- Icon for callouts (e.g., > note, > warning).
                border = "none",     -- Border style for callouts.
                line_padding = 1,    -- Padding at the start of each line.
                color = "String",    -- Highlight group for callout text.
            },
            table = {
                border = "solid",    -- Border style for tables.
                color = "Type",      -- Highlight group for table elements.
                align = true,        -- Align table columns.
            },
            link = {
                icon = "",         -- Icon for links.
                color = "Identifier", -- Highlight group for link text.
            },
            latex_block = {
                enabled = true,      -- Enable LaTeX block rendering.
                color = "Special",   -- Highlight group for LaTeX blocks.
            },
        },
        performance = {
            max_lines = 5000, -- Disable rendering for files with more than 5000 lines.
        },
    },
    config = function(_, opts)
        require("render-markdown").setup(opts)

        -- Keybindings for interacting with render-markdown.nvim.
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