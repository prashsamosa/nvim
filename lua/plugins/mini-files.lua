-- plugins/minifiles.lua
return {
  'echasnovski/mini.files',
  version = '*',
  lazy = false,
  config = function()
    local MiniFiles = require('mini.files')

    -- Setup MiniFiles
    MiniFiles.setup({
      -- Customization of shown content
      content = {
        -- Show all files by default (you can customize this)
        filter = nil,
        -- Use default icons (requires mini.icons or nvim-web-devicons)
        prefix = nil,
        -- Default sorting (directories first, then files alphabetically)
        sort = nil,
      },

      -- Module mappings created only inside explorer
      mappings = {
        close       = 'q',          -- Close explorer
        go_in       = 'l',          -- Enter directory or open file
        go_in_plus  = 'L',          -- Enter directory or open file and close explorer
        go_out      = 'h',          -- Go to parent directory
        go_out_plus = 'H',          -- Go to parent and trim right
        mark_goto   = "'",          -- Go to bookmark
        mark_set    = 'm',          -- Set bookmark
        reset       = '<BS>',       -- Reset to anchor directory
        reveal_cwd  = '@',          -- Reveal current working directory
        show_help   = 'g?',         -- Show help
        synchronize = '=',          -- Apply file operations
        trim_left   = '<',          -- Trim left part of branch
        trim_right  = '>',          -- Trim right part of branch
      },

      -- General options
      options = {
        -- Move to trash instead of permanent delete (safer)
        permanent_delete = false,
        -- Use as default file explorer instead of netrw
        use_as_default_explorer = true,
      },

      -- Customization of explorer windows - adjusted for GitHub theme
      windows = {
        -- Show maximum 4 windows side by side
        max_number = 4,
        -- Enable file preview
        preview = true,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused windows
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 25,
      },
    })

    -- GitHub theme colors for consistency
    local github_colors = {
      bg = "#0d1117",
      bg_float = "#161b22",
      bg_sidebar = "#0d1117",
      fg = "#c9d1d9",
      border = "#30363d",
      keyword = "#ff7b72",
      constant = "#79c0ff",
      func = "#d2a8ff",
      string = "#a5d6ff",
      comment = "#8b949e",
      git_removed = "#f85149",
      warning = "#f0883e",
      success = "#56d364",
      selection = "#264f78",
    }

    -- Apply GitHub theme highlight groups for Mini.files
    local function setup_github_highlights()
      local hl = vim.api.nvim_set_hl

      -- Main Mini.files windows
      hl(0, "MiniFilesBorder", { bg = "none", fg = github_colors.border })
      hl(0, "MiniFilesBorderModified", { bg = "none", fg = github_colors.warning })
      hl(0, "MiniFilesCursorLine", { bg = github_colors.selection })
      hl(0, "MiniFilesDirectory", { fg = github_colors.func, bold = true })
      hl(0, "MiniFilesFile", { fg = github_colors.fg })
      hl(0, "MiniFilesNormal", { bg = github_colors.bg_sidebar, fg = github_colors.fg })
      hl(0, "MiniFilesTitle", { fg = github_colors.constant, bold = true })
      hl(0, "MiniFilesTitleFocused", { fg = github_colors.keyword, bold = true })

      -- Preview window
      hl(0, "MiniFilesPreview", { bg = github_colors.bg_float, fg = github_colors.fg })

      -- File type specific highlights
      hl(0, "MiniFilesModified", { fg = github_colors.warning, italic = true })
      hl(0, "MiniFilesHidden", { fg = github_colors.comment, italic = true })
    end

    -- Apply highlights after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_github_highlights,
    })

    -- Apply highlights immediately if already loaded
    setup_github_highlights()

    -- Toggle function for opening/closing MiniFiles
    local minifiles_toggle = function(...)
      if not MiniFiles.close() then
        MiniFiles.open(...)
      end
    end

    -- Global keymaps
    vim.keymap.set('n', '<leader>me', function()
      minifiles_toggle()
    end, { desc = 'Mini Files: Toggle explorer' })

    vim.keymap.set('n', '<leader>mE', function()
      minifiles_toggle(vim.api.nvim_buf_get_name(0))
    end, { desc = 'Mini Files: Open at current file' })

    -- Autocommand for buffer-specific customizations
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        -- Toggle dotfiles visibility
        local show_dotfiles = true
        local filter_show = function(fs_entry) return true end
        local filter_hide = function(fs_entry)
          return not vim.startswith(fs_entry.name, '.')
        end
        local toggle_dotfiles = function()
          show_dotfiles = not show_dotfiles
          local new_filter = show_dotfiles and filter_show or filter_hide
          MiniFiles.refresh({ content = { filter = new_filter } })
        end
        vim.keymap.set('n', 'g.', toggle_dotfiles, {
          buffer = buf_id,
          desc = 'Toggle dotfiles'
        })

        -- Split mappings
        local map_split = function(buf_id, lhs, direction, desc)
          local rhs = function()
            local cur_target = MiniFiles.get_explorer_state().target_window
            local new_target = vim.api.nvim_win_call(cur_target, function()
              vim.cmd(direction .. ' split')
              return vim.api.nvim_get_current_win()
            end)
            MiniFiles.set_target_window(new_target)
          end
          vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
        end

        map_split(buf_id, '<C-s>', 'belowright horizontal', 'Split horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical', 'Split vertical')
        map_split(buf_id, '<C-t>', 'tab', 'Open in new tab')

        -- Utility mappings with GitHub-themed notifications
        local set_cwd = function()
          local path = (MiniFiles.get_fs_entry() or {}).path
          if path == nil then
            return vim.notify('Cursor is not on valid entry', vim.log.levels.WARN)
          end
          vim.fn.chdir(vim.fs.dirname(path))
          vim.notify('📁 CWD set to: ' .. vim.fs.dirname(path), vim.log.levels.INFO)
        end

        local yank_path = function()
          local path = (MiniFiles.get_fs_entry() or {}).path
          if path == nil then
            return vim.notify('Cursor is not on valid entry', vim.log.levels.WARN)
          end
          vim.fn.setreg(vim.v.register, path)
          vim.notify('📋 Yanked: ' .. path, vim.log.levels.INFO)
        end

        local open_with_system = function()
          local path = (MiniFiles.get_fs_entry() or {}).path
          if path == nil then
            return vim.notify('Cursor is not on valid entry', vim.log.levels.WARN)
          end
          vim.ui.open(path)
          vim.notify('🚀 Opened with system default', vim.log.levels.INFO)
        end

        vim.keymap.set('n', 'g~', set_cwd, {
          buffer = buf_id,
          desc = 'Set cwd to current directory'
        })
        vim.keymap.set('n', 'gy', yank_path, {
          buffer = buf_id,
          desc = 'Yank path to clipboard'
        })
        vim.keymap.set('n', 'gx', open_with_system, {
          buffer = buf_id,
          desc = 'Open with system default'
        })
      end,
    })

    -- Window customization with GitHub theme styling
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowOpen',
      callback = function(args)
        local win_id = args.data.win_id

        -- Add subtle transparency (matching your theme config)
        vim.wo[win_id].winblend = 0  -- Set to 0 since you have global transparency

        -- Customize border with rounded style (matching GitHub aesthetic)
        local config = vim.api.nvim_win_get_config(win_id)
        config.border = 'rounded'
        vim.api.nvim_win_set_config(win_id, config)

        -- Set window-local options for better GitHub theme integration
        vim.wo[win_id].winhighlight = 'Normal:MiniFilesNormal,FloatBorder:MiniFilesBorder,CursorLine:MiniFilesCursorLine'
      end,
    })

    -- Set bookmarks when opening explorer
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        -- Set common bookmarks
        MiniFiles.set_bookmark('c', vim.fn.stdpath('config'), { desc = '⚙️  Config directory' })
        MiniFiles.set_bookmark('d', vim.fn.stdpath('data'), { desc = '💾 Data directory' })
        MiniFiles.set_bookmark('h', vim.fn.expand('~'), { desc = '🏠 Home directory' })
        MiniFiles.set_bookmark('w', vim.fn.getcwd, { desc = '💼 Working directory' })

        -- Project-specific bookmarks (customize as needed)
        if vim.fn.isdirectory('.git') == 1 then
          MiniFiles.set_bookmark('r', '.', { desc = '📂 Project root' })
        end
      end,
    })

    -- Enhanced file operations feedback with GitHub-style notifications
    vim.api.nvim_create_autocmd('User', {
      pattern = {
        'MiniFilesActionCreate',
        'MiniFilesActionDelete',
        'MiniFilesActionRename',
        'MiniFilesActionCopy',
        'MiniFilesActionMove',
      },
      callback = function(event)
        local data = event.data
        local action = data.action:gsub('^%l', string.upper) -- Capitalize first letter
        local from_path = data.from and vim.fn.fnamemodify(data.from, ':t') or ''
        local to_path = data.to and vim.fn.fnamemodify(data.to, ':t') or ''

        local message, icon, level
        if action == 'Create' then
          message = string.format('%s %s: %s', '✨', action, to_path)
          level = vim.log.levels.INFO
        elseif action == 'Delete' then
          message = string.format('%s %s: %s', '🗑️', action, from_path)
          level = vim.log.levels.WARN
        elseif action == 'Rename' then
          message = string.format('%s %s: %s → %s', '📝', action, from_path, to_path)
          level = vim.log.levels.INFO
        elseif action == 'Copy' then
          message = string.format('%s %s: %s → %s', '📋', action, from_path, to_path)
          level = vim.log.levels.INFO
        elseif action == 'Move' then
          message = string.format('%s %s: %s → %s', '📦', action, from_path, to_path)
          level = vim.log.levels.INFO
        end

        vim.notify(message, level)
      end,
    })
  end,
}
