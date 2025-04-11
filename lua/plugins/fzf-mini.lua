return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    "nvim-tree/nvim-web-devicons",
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys={
        { 
            "<leader>zf",  -- Changed from <leader>ff
            function() require('fzf-lua').files() end,
            desc="[Z]FZ Find Files"
        },
        { 
            "<leader>zg",  -- Changed from <leader>fg
            function() require('fzf-lua').live_grep() end,
            desc="[Z]FZ Live Grep"
        },
        { 
            "<leader>zc",  -- Changed from <leader>fc
            function() require('fzf-lua').files({cwd=vim.fn.stdpath("config")}) end,
            desc="[Z]FZ Find in Config"
        },
        {
            "<leader>zh",  -- Changed from <leader>fh
            function()
                require("fzf-lua").helptags()
            end,
            desc = "[Z]FZ [H]elptags",
        },
        {
            "<leader>zk",  -- Changed from <leader>fk
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "[Z]FZ [K]eymaps",
        },
        {
            "<leader>zb",  -- Changed from <leader>fb
            function()
                require("fzf-lua").builtin()
            end,
            desc = "[Z]FZ [B]uiltins",
        },
        {
            "<leader>zw",  -- Changed from <leader>fw
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[Z]FZ Find current [W]ord",
        },
        {
            "<leader>zW",  -- Changed from <leader>fW
            function()
                require("fzf-lua").grep_cWORD()
            end,
            desc = "[Z]FZ Find current [W]ORD",
        },
        {
            "<leader>zd",  -- Changed from <leader>fd
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "[Z]FZ [D]iagnostics",
        },
        {
            "<leader>zr",  -- Changed from <leader>fr
            function()
                require("fzf-lua").resume()
            end,
            desc = "[Z]FZ [R]esume",
        },
        {
            "<leader>zo",  -- Changed from <leader>fo
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "[Z]FZ [O]ld Files",
        },
        {
            "<leader>z<space>",  -- Changed from <leader><leader>
            function()
                require("fzf-lua").buffers()
            end,
            desc = "[Z]FZ Buffers",
        },
        {
            "<leader>z/",  -- Changed from <leader>/
            function()
                require("fzf-lua").lgrep_curbuf()
            end,
            desc = "[Z]FZ Live grep current buffer",
        },
    }
}