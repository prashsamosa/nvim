return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = function()
    local fzf = require("fzf-lua")
    return {
      { "<leader>ff",  fzf.files,                                                             desc = "Find Files" },
      { "<leader>fc",  function() fzf.files({ cwd = vim.fn.stdpath("config") }) end,          desc = "Find in Config" },
      { "<leader>fg",  fzf.live_grep,                                                         desc = "Live Grep" },
      { "<leader>f/",  function() fzf.live_grep_native({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Grep Current Dir" },
      { "<leader>fo",  fzf.oldfiles,                                                          desc = "Recent Files" },
      { "<leader>fB",  fzf.buffers,                                                           desc = "Open Buffers" },
      { "<leader>fb",  fzf.commands,                                                          desc = "Commands" },
      { "<leader>fw",  fzf.grep_cword,                                                        desc = "Find Word" },
      { "<leader>fW",  fzf.grep_cWORD,                                                        desc = "Find WORD" },
      { "<leader>fh",  fzf.helptags,                                                          desc = "Help Tags" },
      { "<leader>fk",  fzf.keymaps,                                                           desc = "Keymaps" },
      { "<leader>fd",  fzf.diagnostics_document,                                              desc = "Document Diagnostics" },
      { "<leader>fr",  fzf.resume,                                                            desc = "Resume Search" },
      { "<leader>fgd", fzf.lsp_definitions,                                                   desc = "LSP Definition" },
      { "<leader>fgr", fzf.lsp_references,                                                    desc = "LSP References" },
      { "<leader>fgi", fzf.lsp_implementations,                                               desc = "LSP Implementation" },
      { "<leader>fgt", fzf.lsp_typedefs,                                                      desc = "LSP Type Definition" },
      { "<leader>fds", fzf.lsp_document_symbols,                                              desc = "Document Symbols" },
      { "<leader>fws", fzf.lsp_workspace_symbols,                                             desc = "Workspace Symbols" },
    }
  end,
  config = function()
    local ok, fzf = pcall(require, "fzf-lua")
    if not ok then
      vim.notify("fzf-lua not found!", vim.log.levels.ERROR)
      return
    end

    fzf.setup({
      winopts = {
        preview = { default = 'bat' }, -- try bat for code preview
        width = 0.85,
        height = 0.75,
        border = 'rounded',
      },
      fzf_opts = {
        ['--ansi'] = true,
        ['--prompt'] = '❯ ',
        ['--layout'] = 'reverse',
        ['--info'] = 'inline',
      },
    })
  end,
}
