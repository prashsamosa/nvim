return {
  "ibhagwan/fzf-lua",
  dependencies = "nvim-tree/nvim-web-devicons",

  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>",                desc = "Find files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>",            desc = "Live grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>",              desc = "Buffers" },
    { "<leader>fh", "<cmd>FzfLua helptags<cr>",             desc = "Help tags" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<cr>",             desc = "Recent files" },
    { "<leader>fc", "<cmd>FzfLua commands<cr>",             desc = "Commands" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>",              desc = "Keymaps" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>",           desc = "Find word under cursor" },
    { "<leader>fr", "<cmd>FzfLua resume<cr>",               desc = "Resume last search" },
    {
      "<leader>fC",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find in config"
    },
    {
      "<leader>f/",
      function()
        require("fzf-lua").live_grep({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Grep current dir"
    },
    { "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Find WORD under cursor" },
  },

  opts = {
    winopts = {
      height = 0.75,
      width = 0.85,
      border = "rounded",
      preview = { default = "bat" },
    },
    fzf_opts = {
      ["--prompt"] = "❯ ",
      ["--layout"] = "reverse",
      ["--info"] = "inline",
    },
  },
}
