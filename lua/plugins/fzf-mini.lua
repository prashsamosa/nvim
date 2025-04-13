-- This file configures the 'fzf-lua' plugin, which provides a fast and
-- versatile fuzzy finder interface within Neovim, integrated with various
-- sources like files, buffers, LSP, Git, etc.

return {
  "ibhagwan/fzf-lua", -- The plugin specification: name of the GitHub repository.
  -- Specifies other plugins that 'fzf-lua' depends on.
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional dependency for icons in the finder.
  keys = { -- Define keybindings for various 'fzf-lua' functionalities.
    -- Changed prefix from <leader>z to <leader>f
    {
      "<leader>ff", -- Find files using FZF.
      function()
        require("fzf-lua").files() -- Opens the fuzzy file finder.
      end,
      desc = "[F]ZF Find Files", -- Description for 'which-key.nvim'.
    },
    {
      "<leader>fg", -- Live grep using FZF.
      function()
        require("fzf-lua").live_grep() -- Opens fuzzy live grep.
      end,
      desc = "[F]ZF Live Grep",
    },
    {
      "<leader>fc", -- Find files within the Neovim configuration directory.
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) -- Restricts search to config dir.
      end,
      desc = "[F]ZF Find in Config",
    },
    {
      "<leader>fh", -- Search help tags using FZF.
      function()
        require("fzf-lua").helptags() -- Opens fuzzy search for help tags.
      end,
      desc = "[F]ZF [H]elptags",
    },
    {
      "<leader>fo", -- Search old files (recently used) using FZF.
      function()
        require("fzf-lua").oldfiles() -- Opens fuzzy search for recently opened files.
      end,
      desc = "[F]ZF [O]ld Files",
    },
    {
      "<leader>fw", -- Find occurrences of the word under the cursor using FZF.
      function()
        require("fzf-lua").grep_cword() -- Greps for the word under the cursor.
      end,
      desc = "[F]ZF Find [W]ord",
    },
    {
      "<leader>fW", -- Find occurrences of the WORD under the cursor (includes punctuation) using FZF.
      function()
        require("fzf-lua").grep_cWORD() -- Greps for the WORD under the cursor.
      end,
      desc = "[F]ZF Find [W]ORD",
    },
    {
      "<leader>fr", -- Resume the last FZF search.
      function()
        require("fzf-lua").resume() -- Resumes the previous FZF session.
      end,
      desc = "[F]ZF [R]esume Search",
    },
    {
      "<leader>f/", -- Live grep within the current buffer using FZF.
      function()
        require("fzf-lua").live_grep_native({ cwd = vim.fn.expand("%:p:h") }) -- Greps within the current buffer's directory? (Check fzf-lua docs for buffer-only grep)
        -- Alternative: require("fzf-lua").buffer_lines() might be closer if you just want buffer lines
      end,
      desc = "[F]ZF Grep Buffer",
    },
    {
      "<leader>f<space>", -- Browse open buffers using FZF.
      function()
        require("fzf-lua").buffers() -- Opens fuzzy search for open buffers.
      end,
      desc = "[F]ZF Buffers",
    },
    {
      "<leader>fd", -- Show diagnostics (errors/warnings) using FZF.
      function()
        require("fzf-lua").diagnostics_document() -- Shows diagnostics for the current document.
        -- Use diagnostics_workspace() for project-wide diagnostics.
      end,
      desc = "[F]ZF [D]iagnostics",
    },
    {
      "<leader>fk", -- Show available key mappings using FZF.
      function()
        require("fzf-lua").keymaps() -- Opens fuzzy search for keymaps.
      end,
      desc = "[F]ZF [K]eymaps",
    },
    {
      "<leader>fb", -- Show Neovim built-in commands using FZF.
      function()
        require("fzf-lua").commands() -- Opens fuzzy search for commands.
      end,
      desc = "[F]ZF [B]uiltins/Commands",
    },
    -- LSP related FZF mappings (already using gd, gr etc. or handled elsewhere)
    -- { "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Goto Definition" },
    -- { "gr", function() require("fzf-lua").lsp_references() end, desc = "Goto References" },
    -- { "gI", function() require("fzf-lua").lsp_implementations() end, desc = "Goto Implementation" },
    -- { "<leader>D", function() require("fzf-lua").lsp_typedefs() end, desc = "Type Definition" },
    -- { "<leader>ds", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document Symbols" },
    -- { "<leader>ws", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Workspace Symbols" },
  },
  config = function()
    -- Optional: Setup fzf-lua with specific options if needed.
    -- require('fzf-lua').setup({})
  end,
}