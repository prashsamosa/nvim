return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        -- Changed provider from openai to gemini
        provider = "gemini",
        -- Removed OpenAI configuration
        -- Added Gemini configuration
        gemini = {
            model = "gemini-2.0-flash", -- Using Gemini 2.0 Flash for faster responses
            timeout = 30000, -- 30 second timeout for API calls
            temperature = 0, -- 0 for consistent, deterministic responses
            max_tokens = 4096, -- Maximum token limit for Gemini
            -- API key is taken from GEMINI_API_KEY environment variable by default
            -- If needed, you can explicitly set: api_key = vim.env.GEMINI_API_KEY,
        },
        behaviour = {
            auto_suggestions = false, -- Experimental feature, disabled for stability
            auto_set_highlight_group = true, -- Enable syntax highlighting
            auto_set_keymaps = true, -- Let Avante set up its keymaps
            auto_apply_diff_after_generation = false, -- Manual review before applying changes
        },
    },
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
