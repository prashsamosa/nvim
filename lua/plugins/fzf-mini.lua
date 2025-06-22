-- Configure the 'fzf-lua' plugin for fast and efficient fuzzy finding.
return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff",       function() require("fzf-lua").files() end,                                            desc = "[F]ZF Find Files" },
    { "<leader>fc",       function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,          desc = "[F]ZF Find in Config" },
    { "<leader>fg",       function() require("fzf-lua").live_grep() end,                                        desc = "[F]ZF Live Grep" },
    { "<leader>f/",       function() require("fzf-lua").live_grep_native({ cwd = vim.fn.expand("%:p:h") }) end, desc = "[F]ZF Grep Buffer" },
    { "<leader>fo",       function() require("fzf-lua").oldfiles() end,                                         desc = "[F]ZF [O]ld Files" },
    { "<leader>f<space>", function() require("fzf-lua").buffers() end,                                          desc = "[F]ZF Buffers" },
    { "<leader>fb",       function() require("fzf-lua").commands() end,                                         desc = "[F]ZF [B]uiltins/Commands" },
    { "<leader>fw",       function() require("fzf-lua").grep_cword() end,                                       desc = "[F]ZF Find [W]ord" },
    { "<leader>fW",       function() require("fzf-lua").grep_cWORD() end,                                       desc = "[F]ZF Find [W]ORD" },
    { "<leader>fh",       function() require("fzf-lua").helptags() end,                                         desc = "[F]ZF [H]elptags" },
    { "<leader>fk",       function() require("fzf-lua").keymaps() end,                                          desc = "[F]ZF [K]eymaps" },
    { "<leader>fd",       function() require("fzf-lua").diagnostics_document() end,                             desc = "[F]ZF [D]iagnostics" },
    { "<leader>fr",       function() require("fzf-lua").resume() end,                                           desc = "[F]ZF [R]esume Search" },
    { "<leader>fgd",      function() require("fzf-lua").lsp_definitions() end,                                  desc = "[F]ZF Goto Definition" },
    { "<leader>fgr",      function() require("fzf-lua").lsp_references() end,                                   desc = "[F]ZF Goto References" },
    { "<leader>fgi",      function() require("fzf-lua").lsp_implementations() end,                              desc = "[F]ZF Goto Implementation" },
    { "<leader>fgt",      function() require("fzf-lua").lsp_typedefs() end,                                     desc = "[F]ZF Type Definition" },
    { "<leader>fds",      function() require("fzf-lua").lsp_document_symbols() end,                             desc = "[F]ZF Document Symbols" },
    { "<leader>fws",      function() require("fzf-lua").lsp_workspace_symbols() end,                            desc = "[F]ZF Workspace Symbols" },
  },
  config = function()
    -- Optional: Customize behavior
    -- require("fzf-lua").setup({
    --   fzf_opts = { ['--prompt'] = '> ' },
    --   winopts = { width = 0.8, height = 0.6 },
    -- })
  end,
}
