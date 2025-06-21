return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",
    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",
    -- Language-specific debuggers
    "leoluz/nvim-dap-go", -- Golang
    -- Shows variable values inline as virtual text
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    -- Core debugging controls
    { "<leader>dc", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
    { "<leader>dsi", function() require("dap").step_into() end, desc = "Debug: Step Into" },
    { "<leader>dso", function() require("dap").step_over() end, desc = "Debug: Step Over" },
    { "<leader>dsO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    { "<leader>dr", function() require("dap").run_last() end, desc = "Debug: Run Last Configuration" },
    { "<leader>dR", function() require("dap").restart() end, desc = "Debug: Restart" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },

    -- Breakpoint management
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Conditional Breakpoint" },
    { "<leader>dbc", function() require("dap").clear_breakpoints() end, desc = "Debug: Clear All Breakpoints" },
    { "<leader>dbl", function() require("dap").list_breakpoints() end, desc = "Debug: List Breakpoints" },

    -- UI controls
    { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Debug: Evaluate Expression", mode = { "n", "v" } },
    { "<leader>dE", function() require("dapui").eval(vim.fn.input("Expression: ")) end, desc = "Debug: Evaluate Input" },

    -- REPL
    { "<leader>do", function() require("dap").repl.open() end, desc = "Debug: Open REPL" },
    { "<leader>dO", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP UI with custom configuration
    dapui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "⏏",
          pause = "⏸",
          play = "▶",
          run_last = "▶▶",
          step_back = "⏮",
          step_into = "⏎",
          step_out = "⏭",
          step_over = "⏯",
          terminate = "⏹",
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = "▸",
        current_frame = "▶",
        expanded = "▾",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "right",
          size = 50,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    })

    -- Setup virtual text for inline variable display
    require("nvim-dap-virtual-text").setup({
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
        if options.virt_text_pos == "inline" then
          return " = " .. variable.value
        else
          return variable.name .. " = " .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil,
    })

    -- Auto-open/close DAP UI
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Exception breakpoints
    dap.defaults.fallback.exception_breakpoints = { "uncaught" }

    -- JavaScript/TypeScript/Node.js debugging setup
    for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
      local pwaType = "pwa-" .. adapterType

      dap.adapters[pwaType] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Handle launch.json configurations
      dap.adapters[adapterType] = function(cb, config)
        local nativeAdapter = dap.adapters[pwaType]
        config.type = pwaType
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    -- Helper function for browser debugging
    local function enter_launch_url()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
          if url == nil or url == "" then
            return
          else
            coroutine.resume(co, url)
          end
        end)
      end)
    end

    -- JavaScript/TypeScript configurations
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (Node.js)",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process (Node.js)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (ts-node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "-r", "ts-node/register" },
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = enter_launch_url,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
        },
        {
          type = "pwa-msedge",
          request = "launch",
          name = "Launch Edge",
          url = enter_launch_url,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
        },
      }
    end

    -- C# debugging setup (Windows specific path - adjust as needed)
    if vim.fn.has("win32") == 1 then
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
        args = { "--interpreter=vscode" },
      }
    else
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }
    end

    -- Helper functions for .NET debugging
    local function dotnet_build_project()
      local default_path = vim.fn.getcwd() .. "/"
      if vim.g["dotnet_last_proj_path"] ~= nil then
        default_path = vim.g["dotnet_last_proj_path"]
      end

      local path = vim.fn.input("Path to your *proj file: ", default_path, "file")
      vim.g["dotnet_last_proj_path"] = path

      local cmd = "dotnet build -c Debug " .. path
      print("Building: " .. cmd)

      local handle = io.popen(cmd .. " 2>&1")
      local result = handle:read("*a")
      local success = handle:close()

      if success then
        print("Build: ✅ Success")
      else
        print("Build: ❌ Failed")
        print(result)
      end
    end

    local function dotnet_get_dll_path()
      local request = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end

      if vim.g["dotnet_last_dll_path"] == nil then
        vim.g["dotnet_last_dll_path"] = request()
      else
        if vim.fn.confirm("Change dll path?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2) == 1 then
          vim.g["dotnet_last_dll_path"] = request()
        end
      end

      return vim.g["dotnet_last_dll_path"]
    end

    -- C# configurations
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "Launch .NET Core",
        request = "launch",
        program = function()
          if vim.fn.confirm("Build project first?", "&yes\n&no", 2) == 1 then
            dotnet_build_project()
          end
          return dotnet_get_dll_path()
        end,
      },
    }

    -- Python debugging setup
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        local port = (config.connect or config).port
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })
      else
        cb({
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return "/usr/bin/python3"
        end,
      },
    }

    -- Go debugging setup (handled by nvim-dap-go)
    require("dap-go").setup({
      delve = {
        -- Use Mason's delve installation with fallback
        path = function()
          local mason_delve = vim.fn.stdpath("data") .. "/mason/bin/dlv"
          if vim.fn.executable(mason_delve) == 1 then
            return mason_delve
          end
          return vim.fn.exepath("dlv") ~= "" and vim.fn.exepath("dlv") or "dlv"
        end,
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = {},
        -- On Windows delve must be run attached or it crashes
        detached = vim.fn.has("win32") == 0,
      },
    })

    -- Utility function to convert string args to array
    local function convertArgStringToArray(config)
      local c = {}
      for k, v in pairs(vim.deepcopy(config)) do
        if k == "args" and type(v) == "string" then
          c[k] = require("dap.utils").splitstr(v)
        else
          c[k] = v
        end
      end
      return c
    end

    -- Apply arg conversion to all configurations
    for key, _ in pairs(dap.configurations) do
      dap.listeners.on_config[key] = convertArgStringToArray
    end

    -- Enhanced continue function with launch.json support
    local function continue_with_launch_json()
      if vim.fn.filereadable(".vscode/launch.json") then
        local ok, _ = pcall(require, "dap.ext.vscode")
        if ok then
          require("dap.ext.vscode").load_launchjs(nil, {
            ["pwa-node"] = { "javascript", "typescript" },
            ["node"] = { "javascript", "typescript" },
            ["pwa-chrome"] = { "javascript", "typescript" },
            ["chrome"] = { "javascript", "typescript" },
          })
        end
      end
      dap.continue()
    end

    -- Override the continue keymap to include launch.json support
    vim.keymap.set("n", "<leader>dc", continue_with_launch_json, { desc = "Debug: Start/Continue" })

    -- Additional Go-specific keymaps
    vim.keymap.set("n", "<leader>dgt", function()
      require("dap-go").debug_test()
    end, { desc = "Debug: Go Test" })

    vim.keymap.set("n", "<leader>dgl", function()
      require("dap-go").debug_last_test()
    end, { desc = "Debug: Go Last Test" })

    -- Sign configuration
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })

    vim.notify("DAP configuration loaded", vim.log.levels.INFO, { title = "nvim-dap" })
  end,
}
