return {
  "dnlhc/glance.nvim",
  cmd = "Glance",
  config = function()
    require("glance").setup({
      height = 18, -- Height of the window
      zindex = 45,

      -- By default glance will open preview "embedded" within your active buffer
      -- when `detached` is enabled, glance will render above all existing buffers
      -- and won't be restrained by the width of your active buffer
      detached = true,

      preview_win_opts = { -- Configure preview window options
        cursorline = true,
        number = true,
        wrap = true,
      },

      list = {
        position = "right", -- Position of the list window 'left'|'right'
        size = "33%",
      },

      theme = {        -- This feature might not work properly in nvim-0.7.2
        enable = true, -- Will generate colors for the plugin based on your current colorscheme
        mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
      },

      mappings = {
        list = {
          ["j"] = require("glance").actions.next,     -- Bring the cursor to the next item in the list
          ["k"] = require("glance").actions.previous, -- Bring the cursor to the previous item in the list
          ["<Down>"] = require("glance").actions.next,
          ["<Up>"] = require("glance").actions.previous,
          ["<Tab>"] = require("glance").actions.next_location,       -- Bring the cursor to the next location skipping groups
          ["<S-Tab>"] = require("glance").actions.previous_location, -- Bring the cursor to the previous location skipping groups
          ["<C-u>"] = require("glance").actions.preview_scroll_win(5),
          ["<C-d>"] = require("glance").actions.preview_scroll_win(-5),
          ["v"] = require("glance").actions.jump_vsplit,
          ["s"] = require("glance").actions.jump_split,
          ["t"] = require("glance").actions.jump_tab,
          ["<CR>"] = require("glance").actions.jump,
          ["o"] = require("glance").actions.jump,
          ["l"] = require("glance").actions.open_fold,
          ["h"] = require("glance").actions.close_fold,
          ["<leader>l"] = require("glance").actions.enter_win("preview"), -- Focus preview window
          ["q"] = require("glance").actions.close,
          ["Q"] = require("glance").actions.close,
          ["<Esc>"] = require("glance").actions.close,
          ["<C-q>"] = require("glance").actions.quickfix,
        },
        preview = {
          ["Q"] = require("glance").actions.close,
          ["<Tab>"] = require("glance").actions.next_location,
          ["<S-Tab>"] = require("glance").actions.previous_location,
          ["<leader>l"] = require("glance").actions.enter_win("list"), -- Focus list window
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
