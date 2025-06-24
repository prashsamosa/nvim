return {
  "dnlhc/glance.nvim",
  cmd = "Glance",
  config = function()
    require("glance").setup({
      height = 18,
      zindex = 45,
      detached = true,
      preview_win_opts = {
        cursorline = true,
        number = true,
        wrap = true,
      },
      list = {
        position = "right",
        size = "33%",
      },
      theme = {
        enable = true,
        mode = "auto",
      },
      mappings = {
        list = {
          ["j"] = require("glance").actions.next,
          ["k"] = require("glance").actions.previous,
          ["<Down>"] = require("glance").actions.next,
          ["<Up>"] = require("glance").actions.previous,
          ["<Tab>"] = require("glance").actions.next_location,
          ["<S-Tab>"] = require("glance").actions.previous_location,
          ["<C-u>"] = require("glance").actions.preview_scroll_win(5),
          ["<C-d>"] = require("glance").actions.preview_scroll_win(-5),
          ["v"] = require("glance").actions.jump_vsplit,
          ["s"] = require("glance").actions.jump_split,
          ["t"] = require("glance").actions.jump_tab,
          ["<CR>"] = require("glance").actions.jump,
          ["o"] = require("glance").actions.jump,
          ["l"] = require("glance").actions.open_fold,
          ["h"] = require("glance").actions.close_fold,
          ["<leader>l"] = require("glance").actions.enter_win("preview"),
          ["q"] = require("glance").actions.close,
          ["Q"] = require("glance").actions.close,
          ["<Esc>"] = require("glance").actions.close,
          ["<C-q>"] = require("glance").actions.quickfix,
        },
        preview = {
          ["Q"] = require("glance").actions.close,
          ["<Tab>"] = require("glance").actions.next_location,
          ["<S-Tab>"] = require("glance").actions.previous_location,
          ["<leader>l"] = require("glance").actions.enter_win("list"),
        },
      },
      hooks = {
        before_open = function(results, open, jump, method)
          local uri = vim.uri_from_bufnr(0)
          if #results == 1 then
            local target_uri = results[1].uri or results[1].targetUri
            if target_uri == uri then
              jump(results[1])
            else
              open(results)
            end
          else
            open(results)
          end
        end,
      },
    })
  end,
  keys = {
    { "<leader>ld", "<CMD>Glance definitions<CR>",      desc = "LSP Definitions (Glance)" },
    { "<leader>lr", "<CMD>Glance references<CR>",       desc = "LSP References (Glance)" },
    { "<leader>lt", "<CMD>Glance type_definitions<CR>", desc = "LSP Type Definitions (Glance)" },
    { "<leader>li", "<CMD>Glance implementations<CR>",  desc = "LSP Implementations (Glance)" },
  },
}
