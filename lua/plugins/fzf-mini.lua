-- Configure the 'fzf-lua' plugin for fast and efficient fuzzy finding.
-- It provides a powerful interface to search various Neovim sources.

return {
    "ibhagwan/fzf-lua", -- Plugin specification.
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: Icons in the FZF list.
    keys = { -- Keybindings for 'fzf-lua' functionalities (prefix changed to <leader>f).
      {
        "<leader>ff", -- Find files in the current working directory.
        function() require("fzf-lua").files() end,
        desc = "[F]ZF Find Files",
      },
      {
        "<leader>fg", -- Live grep (find text in files).
        function() require("fzf-lua").live_grep() end,
        desc = "[F]ZF Live Grep",
      },
      {
        "<leader>fc", -- Find files within the Neovim configuration directory.
        function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
        desc = "[F]ZF Find in Config",
      },
      {
        "<leader>fh", -- Find Neovim help tags.
        function() require("fzf-lua").helptags() end,
        desc = "[F]ZF [H]elptags",
      },
      {
        "<leader>fo", -- Find recently opened files.
        function() require("fzf-lua").oldfiles() end,
        desc = "[F]ZF [O]ld Files",
      },
      {
        "<leader>fw", -- Grep for the word under the cursor.
        function() require("fzf-lua").grep_cword() end,
        desc = "[F]ZF Find [W]ord",
      },
      {
        "<leader>fW", -- Grep for the WORD under the cursor (including punctuation).
        function() require("fzf-lua").grep_cWORD() end,
        desc = "[F]ZF Find [W]ORD",
      },
      {
        "<leader>fr", -- Resume the last FZF search.
        function() require("fzf-lua").resume() end,
        desc = "[F]ZF [R]esume Search",
      },
      {
        "<leader>f/", -- Live grep in the current buffer's directory (or buffer lines).
        function()
          -- Consider using buffer_lines() if you only want to search within the current buffer.
          require("fzf-lua").live_grep_native({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "[F]ZF Grep Buffer",
      },
      {
        "<leader>f<space>", -- Find open buffers.
        function() require("fzf-lua").buffers() end,
        desc = "[F]ZF Buffers",
      },
      {
        "<leader>fd", -- Show diagnostics for the current document.
        function() require("fzf-lua").diagnostics_document() end,
        -- Use require("fzf-lua").diagnostics_workspace() for project-wide diagnostics.
        desc = "[F]ZF [D]iagnostics",
      },
      {
        "<leader>fk", -- Find available key mappings.
        function() require("fzf-lua").keymaps() end,
        desc = "[F]ZF [K]eymaps",
      },
      {
        "<leader>fb", -- Find Neovim built-in commands.
        function() require("fzf-lua").commands() end,
        desc = "[F]ZF [B]uiltins/Commands",
      },
      -- LSP related FZF mappings
      {
        "<leader>gd",
        function() require("fzf-lua").lsp_definitions() end,
        desc = "[F]ZF Goto Definition",
      },
      {
        "<leader>gr",
        function() require("fzf-lua").lsp_references() end,
        desc = "[F]ZF Goto References",
      },
      {
        "<leader>gi",
        function() require("fzf-lua").lsp_implementations() end,
        desc = "[F]ZF Goto Implementation",
      },
      {
        "<leader>gt",
        function() require("fzf-lua").lsp_typedefs() end,
        desc = "[F]ZF Type Definition",
      },
      {
        "<leader>cs", -- This was the problematic keymap in your keymaps.lua
        function() require("fzf-lua").lsp_document_symbols() end,
        desc = "[F]ZF Document Symbols",
      },
      {
        "<leader>ws",
        function() require("fzf-lua").lsp_workspace_symbols() end,
        desc = "[F]ZF Workspace Symbols",
      },
    },
    config = function()
      -- Optional: Configure fzf-lua with custom options if needed.
      -- require('fzf-lua').setup({})
    end,
  }