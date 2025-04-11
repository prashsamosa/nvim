return {
    -- Core mini.nvim library (required for other modules)
    {
      'echasnovski/mini.nvim',
      version = false,
    },
  
    -- Buffer removal
    {
      'echasnovski/mini.bufremove',
      version = false,
      config = function()
        vim.keymap.set('n', '<leader>mb', function() -- Changed from <leader>bd to <leader>mb
          require('mini.bufremove').delete(0, false)
        end, { desc = 'Mini delete buffer' })
  
        vim.keymap.set('n', '<leader>mB', function() -- Changed from <leader>bD to <leader>mB
          require('mini.bufremove').delete(0, true)
        end, { desc = 'Mini force delete buffer' })
      end,
    },
  
    -- File explorer
    {
      'echasnovski/mini.files',
      version = false,
      config = function()
        require('mini.files').setup()
        vim.keymap.set('n', '<leader>me', function() -- Changed from <leader>e to <leader>me
          require('mini.files').open()
        end, { desc = 'Mini file explorer' })
      end,
    },
  
    -- Fuzzy finder / picker
    {
      'echasnovski/mini.pick',
      version = false,
      config = function()
        require('mini.pick').setup()
        vim.keymap.set('n', '<leader>mp', function() -- Changed from <leader>fp to <leader>mp
          require('mini.pick').builtin.files()
        end, { desc = 'Mini pick files' })
  
        vim.keymap.set('n', '<leader>mg', function() -- Changed from <leader>gp to <leader>mg
          require('mini.pick').builtin.grep_live()
        end, { desc = 'Mini grep live' })
      end,
    },
  
    -- Notifications
    {
      'echasnovski/mini.notify',
      version = false,
      event = 'VeryLazy',
      config = function()
        require('mini.notify').setup()
        vim.notify = require('mini.notify').make_notify()
      end,
    },
  
    -- Statusline
    {
      'echasnovski/mini.statusline',
      version = false,
      config = function()
        require('mini.statusline').setup({ use_icons = true })
      end,
    },
  }
