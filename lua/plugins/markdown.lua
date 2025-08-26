return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },

    opts = {
        file_types = { "markdown" },
        render = { max_file_size = 10.0, debounce = 100 },

        heading = {
            enabled = true,
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            width = "full",
            border = true,
            above = "▄",
            below = "▀",
        },

        code = {
            enabled = true,
            style = "full",
            width = "full",
            border = "thin",
            above = "▄",
            below = "▀",
        },

        bullet = { enabled = true, icons = { "●", "○", "◆", "◇" } },

        checkbox = {
            enabled = true,
            unchecked = { icon = "󰄱 " },
            checked = { icon = "󰱒 " },
            custom = { todo = { raw = "[-]", rendered = "󰥔 " } },
        },

        quote = { enabled = true, icon = "▎" },

        pipe_table = {
            enabled = true,
            style = "full",
            cell = "padded",
            border = { "┌", "┬", "┐", "├", "┼", "┤", "└", "┴", "┘", "│", "─" },
        },

        callout = {
            note = { raw = "[!NOTE]", rendered = "󰋽 Note" },
            tip = { raw = "[!TIP]", rendered = "󰌶 Tip" },
            important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important" },
            warning = { raw = "[!WARNING]", rendered = "󰀪 Warning" },
            caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution" },
        },

        link = { enabled = true, image = "󰥶 ", email = "󰀓 ", hyperlink = "󰌹 " },
        anti_conceal = { enabled = true },
    },

    config = function(_, opts)
        require("render-markdown").setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>",
                    vim.tbl_extend("force", opts, { desc = "Toggle render" }))
                vim.keymap.set("n", "<leader>me", "<cmd>RenderMarkdown enable<CR>",
                    vim.tbl_extend("force", opts, { desc = "Enable render" }))
                vim.keymap.set("n", "<leader>md", "<cmd>RenderMarkdown disable<CR>",
                    vim.tbl_extend("force", opts, { desc = "Disable render" }))
            end,
        })
    end,
}
