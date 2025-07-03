-- lua/plugins/fzf.lua - fzf-lua configuration

return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Icons in FZF results
  },
  keys = {
    { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>",                                            desc = "Find Files" },
    { "<leader>fC", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })<cr>",          desc = "Find in Config" },
    { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>",                                        desc = "Live Grep" },
    { "<leader>f/", "<cmd>lua require('fzf-lua').live_grep_native({ cwd = vim.fn.expand('%:p:h') })<cr>", desc = "Grep Current Dir" },
    { "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<cr>",                                         desc = "Recent Files" },
    { "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<cr>",                                          desc = "Open Buffers" },
    { "<leader>fc", "<cmd>lua require('fzf-lua').commands()<cr>",                                         desc = "Commands" },
    { "<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<cr>",                                       desc = "Find word under cursor" },
    { "<leader>fW", "<cmd>lua require('fzf-lua').grep_cWORD()<cr>",                                       desc = "Find WORD under cursor" },
    { "<leader>fh", "<cmd>lua require('fzf-lua').helptags()<cr>",                                         desc = "Help Tags" },
    { "<leader>fk", "<cmd>lua require('fzf-lua').keymaps()<cr>",                                          desc = "Keymaps" },
    { "<leader>fd", "<cmd>lua require('fzf-lua').diagnostics_document()<cr>",                             desc = "Document Diagnostics (FZF)" },
    { "<leader>fr", "<cmd>lua require('fzf-lua').resume()<cr>",                                           desc = "Resume Last Search" },
    -- LSP-related mappings are defined in lua/config/keymaps.lua via LspAttach autocmd
  },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      winopts = {
        preview = { default = "bat" }, -- Better syntax highlighting with bat
        width = 0.85,
        height = 0.75,
        border = "rounded",
      },
      fzf_opts = {
        ["--ansi"] = true,
        ["--prompt"] = "❯ ",
        ["--layout"] = "reverse",
        ["--info"] = "inline",
      },
      -- Additional customization (e.g. file_icons, colors) can go here
    })
  end,
}
