return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'leoluz/nvim-dap-go',
    'theHamsta/nvim-dap-virtual-text',
  },
  keys = {
    { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue' },
    { '<leader>dsi', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<leader>dso', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<leader>dsO', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Debug: Conditional Breakpoint' },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    { '<leader>dr', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
    { '<leader>dR', function() require('dap').restart() end, desc = 'Debug: Restart Session' },
    { '<leader>de', function() require('dapui').eval() end, mode = { 'n', 'v' }, desc = 'Debug: Evaluate Expression' },
    { '<leader>dl', function() require('dap').set_log_level('TRACE'); vim.notify('DAP log level set to TRACE', vim.log.levels.INFO) end, desc = 'Debug: Show Logs' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate Session' },
    { '<leader>dk', function() require('dap').up() end, desc = 'Debug: Up Stack Frame' },
    { '<leader>dj', function() require('dap').down() end, desc = 'Debug: Down Stack Frame' },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local dap_virtual_text = require('nvim-dap-virtual-text')
    local dap_go = require('dap-go')

    dapui.setup({
      force_buffers = true,
      icons = {
        expanded = '▾',
        collapsed = '▸',
        current_frame = '▶',
        circular = '○'
      },
      mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      expand_lines = vim.fn.has('nvim-0.7') == 1,
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.30 },
            { id = 'breakpoints', size = 0.20 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 0.25,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 0.6 },
            { id = 'console', size = 0.4 },
          },
          size = 0.25,
          position = 'bottom',
        },
      },
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
        indent = 1,
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
    dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
    dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

    dap_virtual_text.setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    })

    dap_go.setup({
      delve = {
        path = function()
          local ok, mason_registry = pcall(require, 'mason-registry')
          if ok then
            local pkg = mason_registry.get_package('delve')
            if pkg:is_installed() then
              return pkg:get_install_path() .. '/bin/dlv'
            end
          end
          return vim.fn.exepath('dlv') or 'dlv'
        end,
        initialize_timeout_sec = 20,
        port = '${port}',
        args = {},
        build_flags = '',
        detached = vim.fn.has('win32') == 0,
        cwd = nil,
      },
    })

    local signs = {
      DapBreakpoint = { text = '●', texthl = 'DapBreakpoint' },
      DapBreakpointCondition = { text = '◐', texthl = 'DapBreakpointCondition' },
      DapLogPoint = { text = '◆', texthl = 'DapLogPoint' },
      DapStopped = { text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine' },
      DapBreakpointRejected = { text = '○', texthl = 'DapBreakpointRejected' },
    }

    for name, sign in pairs(signs) do
      vim.fn.sign_define(name, sign)
    end

    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  end,
}
