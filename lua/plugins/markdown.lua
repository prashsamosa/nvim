-- ~/.config/nvim/lua/plugins/markdown.lua
return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" }, -- Lazy load on markdown
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim", -- Or use mini.icons if preferred
      -- Alternative: "nvim-tree/nvim-web-devicons"
    },
    opts = {
      completions = {
        blink = {
          enabled = true,
        },
      },
  
      -- Optional fine-tuning (these are sensible defaults)
      appearance = {
        heading = {
          icon = "󰉫", -- or "" for fancier
          border = "solid",
          padding = 1,
          width = "full",
          color = "Title",
        },
        bullet = {
          icon = "•",
          color = "Comment",
          padding = 1,
        },
        checkbox = {
          icons = {
            [" "] = "󰄱", -- Unchecked
            ["x"] = "󰄵", -- Checked
            ["-"] = "󰜺", -- Indeterminate
          },
          color = "Boolean",
        },
        code_block = {
          border = "rounded",
          padding = 1,
          width = "full",
          background = "Visual",
        },
        callout = {
          icon = "", -- Obsidian/GitHub style
          border = "none",
          line_padding = 1,
          color = "String",
        },
        table = {
          border = "solid",
          color = "Type",
          align = true,
        },
        link = {
          icon = "",
          color = "Identifier",
        },
        latex_block = {
          enabled = true,
          color = "Special",
        },
      },
  
      -- Render optimization for large files
      performance = {
        max_lines = 5000, -- disable for huge files
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
  
      -- Helpful keybindings
      local map = vim.keymap.set
      local function nmap(lhs, rhs, desc)
        map("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
      end
  
      -- Toggle & control
      nmap("<leader>um", "<cmd>RenderMarkdown toggle<CR>", "Toggle Markdown Render")
      nmap("<leader>ue", "<cmd>RenderMarkdown expand<CR>", "Expand Markdown View")
      nmap("<leader>uc", "<cmd>RenderMarkdown contract<CR>", "Contract Markdown View")
      nmap("<leader>ul", "<cmd>RenderMarkdown log<CR>", "Open Markdown Log")
      nmap("<leader>ud", "<cmd>RenderMarkdown debug<CR>", "Debug Markdown Line")
      nmap("<leader>us", "<cmd>RenderMarkdown config<CR>", "Show Markdown Config")
    end,
  }
  