return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
  },
  cmd = {
    "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto",
    "DapStepOut", "DapTerminate", "DapUIOpen", "DapUIClose", "DapUIToggle",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- UI setup
    dapui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "⏏", pause = "⏸", play = "▶", run_last = "▶▶",
          step_back = "⏮", step_into = "⏎", step_out = "⏭",
          step_over = "⏯", terminate = "⏹",
        },
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
    })

    require("nvim-dap-virtual-text").setup({
      enabled = true,
      show_stop_reason = true,
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
    })

    -- Auto open/close DAP UI
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    -- Signs
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", {
      text = "▶",
      texthl = "DapStopped",
      linehl = "DapStoppedLine",
    })
    vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected" })

    -- JavaScript/Node/Chrome
    local mason = require("mason-registry")
    local js_debug_path = mason.get_package("js-debug-adapter"):get_install_path()
    local js_debug_cmd = js_debug_path .. "/js-debug/src/dapDebugServer.js"

    for _, adapter in ipairs({ "node", "chrome", "msedge" }) do
      local pwa = "pwa-" .. adapter
      dap.adapters[pwa] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_cmd, "${port}" },
        },
      }
      dap.adapters[adapter] = function(cb, config)
        config.type = pwa
        cb(dap.adapters[pwa])
      end
    end

    local function enter_launch_url()
      local co = coroutine.running()
      return coroutine.create(function()
        vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
          if url and url ~= "" then coroutine.resume(co, url) end
        end)
      end)
    end

    for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }) do
      dap.configurations[ft] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (Node.js)",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = enter_launch_url,
          webRoot = "${workspaceFolder}",
          port = 9222,
        },
      }
    end

    -- .NET (C#)
    local netcoredbg = mason.get_package("netcoredbg"):get_install_path()
    dap.adapters.coreclr = {
      type = "executable",
      command = netcoredbg .. "/netcoredbg" .. (vim.fn.has("win32") == 1 and ".exe" or ""),
      args = { "--interpreter=vscode" },
    }

    local function dotnet_get_dll()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "Launch .NET",
        request = "launch",
        program = dotnet_get_dll,
      },
    }

    -- Python
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        cb({ type = "server", port = config.connect.port, host = config.connect.host })
      else
        cb({
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
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

    -- Go
    require("dap-go").setup({
      delve = {
        path = function()
          local mason_dlv = vim.fn.stdpath("data") .. "/mason/bin/dlv"
          return vim.fn.executable(mason_dlv) == 1 and mason_dlv or "dlv"
        end,
        initialize_timeout_sec = 20,
      },
    })

    -- Convert string args to list
    for _, configs in pairs(dap.configurations) do
      for _, config in ipairs(configs) do
        if type(config.args) == "string" then
          config.args = vim.split(config.args, " ")
        end
      end
    end

    -- Load .vscode/launch.json if present
    local function continue_with_launch_json()
      if vim.fn.filereadable(".vscode/launch.json") then
        local ok, ext = pcall(require, "dap.ext.vscode")
        if ok then
          ext.load_launchjs(nil, {
            ["pwa-node"] = { "javascript", "typescript" },
            ["pwa-chrome"] = { "javascript", "typescript" },
          })
        end
      end
      dap.continue()
    end

    -- Keybindings
    local map = vim.keymap.set
    map("n", "<leader>dc", continue_with_launch_json, { desc = "Debug: Continue" })
    map("n", "<leader>dsi", dap.step_into, { desc = "Debug: Step Into" })
    map("n", "<leader>dso", dap.step_over, { desc = "Debug: Step Over" })
    map("n", "<leader>dsO", dap.step_out, { desc = "Debug: Step Out" })
    map("n", "<leader>dR", dap.restart, { desc = "Debug: Restart" })
    map("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
    map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    map("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Conditional Breakpoint" })
    map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
    map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Debug: Eval Expression" })
    map("n", "<leader>do", dap.repl.open, { desc = "Debug: Open REPL" })
    map("n", "<leader>dO", dap.repl.toggle, { desc = "Debug: Toggle REPL" })

    -- Go test mappings
    map("n", "<leader>dgt", function() require("dap-go").debug_test() end, { desc = "Debug: Go Test" })
    map("n", "<leader>dgl", function() require("dap-go").debug_last_test() end, { desc = "Debug: Go Last Test" })

    vim.notify("DAP fully configured", vim.log.levels.INFO, { title = "nvim-dap" })
  end,
}
